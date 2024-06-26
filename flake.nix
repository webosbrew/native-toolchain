{
  description = "Cmake with webOS toolchain";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"; };

  outputs = { self, nixpkgs }:
    let
      allSystems = [
        "x86_64-linux" # 64bit AMD/Intel x86
        "aarch64-linux" # 64bit ARM
        "x86_64-darwin" # 64bit AMD/Intel macOS
        "aarch64-darwin" # 64bit ARM macOS
      ];

      forAllSystems = fn:
        nixpkgs.lib.genAttrs allSystems
        (system: fn { pkgs = import nixpkgs { inherit system; }; inherit system;});

      webOSToolchain = {system, fetchurl, runCommand}: let 
          urlToolchain = {
              "x86_64-linux"  = "https://github.com/openlgtv/buildroot-nc4/releases/download/webos-d7ed7ee/arm-webos-linux-gnueabi_sdk-buildroot.tar.gz";
              "aarch64-linux" = "https://github.com/webosbrew/native-toolchain/releases/download/webos-d7ed7ee.6/arm-webos-linux-gnueabi_sdk-buildroot_linux-aarch64.tar.bz2";
              "x86_64-darwin" = "https://github.com/webosbrew/native-toolchain/releases/download/webos-d7ed7ee.6/arm-webos-linux-gnueabi_sdk-buildroot_darwin-x86_64.tar.bz2";
              "aarch64-darwin"= "https://github.com/webosbrew/native-toolchain/releases/download/webos-d7ed7ee.6/arm-webos-linux-gnueabi_sdk-buildroot_darwin-arm64.tar.bz2";
          }."${system}";

          hashToolchain = {
              "x86_64-linux"  = "sha256-MoFmJumfs0kipJ0MY598ijA1b/+yIjctSCMCfxOC9kA=";
              "aarch64-linux" = "sha256-RaLRL/VXRX2SzeT92qd6bxCQ/KA63EO7dDl+Xgw3lQE=";
              "x86_64-darwin" = "sha256-dedFGsOWBIcq5/B4lMvo7bYrIJFmSheByxk+fr5WqnU=";
              "aarch64-darwin"= "sha256-lUMzaUqx/h93N+gaC+HjGIzf/8GhGcgchvX86/GFfEU=";
          }."${system}";

          webosToolchainPkg = fetchurl {
            url = urlToolchain;
            hash = hashToolchain;
          };
      in 
        runCommand "webos-toolchain" {} ''
          mkdir -p $out
          tar -xf ${webosToolchainPkg} -C $out
          mv $out/arm-webos-linux-gnueabi_sdk-buildroot/* $out
          rm -rf $out/arm-webos-linux-gnueabi_sdk-buildroot
        '';
    in {

      defaultPackage = forAllSystems ({ pkgs, system }: pkgs.callPackage webOSToolchain { inherit system; });

      devShells = forAllSystems ({ pkgs, system }: let 
          webOS = (pkgs.callPackage webOSToolchain { inherit system; });
      in
      {
        default = pkgs.mkShell {
          nativeBuildInputs = [ webOS pkgs.cmake ];         
          shellHook = ''
            alias cmake='${pkgs.cmake}/bin/cmake -DCMAKE_TOOLCHAIN_FILE=${webOS}/share/buildroot/toolchainfile.cmake'
            function webos_cmake_kit {
              mkdir -p .vscode
              echo '${builtins.toJSON [{ name = "webos-toolchain"; toolchainFile = "${webOS}/share/buildroot/toolchainfile.cmake";}]}' > .vscode/cmake-kits.json
            }
          '';
        };
      });
    };
}