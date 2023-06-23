set(GCC_VERSION 12.2.0)

set(PREFIX "${BUILDROOT_PORT_PREFIX}")
set(SYSROOT "${PREFIX}/${BUILDROOT_TRIPLE}/sysroot")

file(GLOB GCC_PATCHES "${buildroot-nc4_SOURCE_DIR}/package/gcc/12.2.0/*.patch")
list(TRANSFORM GCC_PATCHES PREPEND "COMMAND;patch;-p1;<;" OUTPUT_VARIABLE GCC_PATCH_COMMANDS)

ExternalProject_Add(gcc DEPENDS binutils gmp mpc mpfr isl
        URL "${GCC_MIRROR}/releases/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP FALSE
        PATCH_COMMAND ${GCC_PATCH_COMMANDS}
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=${PREFIX} --sysconfdir=${PREFIX}/etc --enable-static 
        --build=${CMAKE_C_COMPILER_TARGET} --target=${BUILDROOT_TRIPLE} --with-sysroot=${SYSROOT} --enable-__cxa_atexit
        --with-gnu-ld --disable-libssp --disable-multilib --disable-decimal-float --enable-plugins --enable-lto
        --with-gmp=${PREFIX} --with-mpc=${PREFIX} --with-mpfr=${PREFIX}
        "--with-pkgversion=Buildroot -g${BUILDROOT_BUILD_ID}" "--with-bugurl=http://bugs.buildroot.net"
        --without-zstd --disable-libquadmath --disable-libquadmath-support --enable-tls --enable-threads
        --with-isl=${PREFIX} --with-abi=aapcs-linux --with-cpu=cortex-a9 --with-fpu=neon-fp16 --with-float=softfp
        --with-mode=arm --enable-languages=c,c++ --with-build-time-tools=${PREFIX}/arm-webos-linux-gnueabi/bin
        --enable-shared --disable-libgomp
        BUILD_COMMAND make -j${NPROC}
        INSTALL_COMMAND make install)
