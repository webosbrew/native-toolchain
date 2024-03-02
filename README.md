# Unofficial Native Toolchain for webOS

Ports, downloads and documents for [unofficial webOS NDK](https://github.com/openlgtv/buildroot-nc4).
You can use this tool to develop native applications for your webOS based TV.

---

## Download

| Operating System | x86_64                                                                                 | arm64                                                                                  |
|------------------|----------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|
| Linux            | [arm-webos-linux-gnueabi_sdk-buildroot.tar.gz][toolchain-linux-x86_64]                 | [arm-webos-linux-gnueabi_sdk-buildroot_linux-aarch64.tar.bz2][toolchain-linux-aarch64] |
| macOS            | [arm-webos-linux-gnueabi_sdk-buildroot_darwin-x86_64.tar.bz2][toolchain-darwin-x86_64] | Not available yet                                                                      |

## Install

1. Download tarball for your system listed above
2. Extract the tarball to the location you want (please avoid having spaces and special characters in the path)
3. Run `relocate-sdk.sh` in extracted contents

## Usage

### CMake

When you build a CMake project in command line, assign `CMAKE_TOOLCHAIN_FILE` with toolchain file.

```shell
cmake -B build -DCMAKE_TOOLCHAIN_FILE=/path/to/extracted/tarball/arm-webos-linux-gnueabi_sdk-buildroot/share/buildroot/toolchainfile.cmake
```

For VSCode [CMake Tools](https://github.com/microsoft/vscode-cmake-tools/), add entry in
[Kit options](https://github.com/microsoft/vscode-cmake-tools/blob/main/docs/kits.md#kit-options):

```json
[
  {
    "name": "webOS",
    "toolchainFile": "/path/to/extracted/tarball/arm-webos-linux-gnueabi_sdk-buildroot/share/buildroot/toolchainfile.cmake"
  }
]
```

## Advanced Usage Guide: Building the Port

If your machine is not included, you can build it on your local machine. **Normally, you don't need to do this!**

#### Prerequisites

* GCC
* CMake

#### Build Toolchain Port

Please set `CC` and `CXX` environment variable to binary of GCC you have installed.
If your `LANG` environment variable is not `en_US.UTF-8`, please set to that.

```shell
cmake -E make_directory build
cmake -B build -DCMAKE_INSTALL_PREFIX=/path/to/install/location
cmake --build build 
cmake --install build # Ensure you have write permission to the prefix you set
```

Then the toolchain will be installed to the location you want automatically.

[toolchain-linux-x86_64]: https://github.com/openlgtv/buildroot-nc4/releases/latest/download/arm-webos-linux-gnueabi_sdk-buildroot.tar.gz

[toolchain-linux-aarch64]: https://github.com/webosbrew/native-toolchain/releases/latest/download/arm-webos-linux-gnueabi_sdk-buildroot_linux-aarch64.tar.bz2

[toolchain-darwin-x86_64]: https://github.com/webosbrew/native-toolchain/releases/latest/download/arm-webos-linux-gnueabi_sdk-buildroot_darwin-x86_64.tar.bz2