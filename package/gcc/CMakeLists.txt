set(GCC_VERSION 12.2.0)

set(PREFIX "${HOST_DIR}")
set(SYSROOT "${HOST_DIR}/${GNU_TARGET_NAME}/sysroot")

file(GLOB GCC_PATCHES "${buildroot-nc4_SOURCE_DIR}/package/gcc/12.2.0/*.patch")
list(TRANSFORM GCC_PATCHES PREPEND "COMMAND;patch;-p1;<;" OUTPUT_VARIABLE GCC_PATCH_COMMANDS)

ExternalProject_Get_Property(gmp INSTALL_DIR)
set(GMP_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Get_Property(mpc INSTALL_DIR)
set(MPC_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Get_Property(mpfr INSTALL_DIR)
set(MPFR_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Get_Property(isl INSTALL_DIR)
set(ISL_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(gcc DEPENDS binutils gmp mpc mpfr isl m4
        URL "${GCC_MIRROR}/releases/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        PATCH_COMMAND ${GCC_PATCH_COMMANDS}
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc --enable-static
        --build=${CMAKE_C_COMPILER_TARGET} --target=${GNU_TARGET_NAME} --with-sysroot=${SYSROOT} --enable-__cxa_atexit
        --with-gnu-ld --disable-libssp --disable-multilib --disable-decimal-float --enable-plugins --enable-lto
        --with-gmp=${GMP_INSTALL_DIR} --with-mpc=${MPC_INSTALL_DIR} --with-mpfr=${MPFR_INSTALL_DIR}
        "--with-pkgversion=Buildroot -g${BUILDROOT_BUILD_ID}" "--with-bugurl=http://bugs.buildroot.net"
        --without-zstd --disable-libquadmath --disable-libquadmath-support --enable-tls --enable-threads
        --with-isl=${ISL_INSTALL_DIR} --with-abi=aapcs-linux --with-cpu=cortex-a9 --with-fpu=neon-fp16
        --with-float=softfp --with-mode=arm --enable-languages=c,c++
        --with-build-time-tools=${HOST_DIR}/${GNU_TARGET_NAME}/bin --enable-shared --disable-libgomp MAKEINFO=true
        BUILD_COMMAND make -j${NPROC} MAKEINFO=true
        INSTALL_COMMAND make install MAKEINFO=true
#            COMMAND ${CMAKE_COMMAND} -DBINDIR=${PREFIX}/bin -DGNU_TARGET_NAME=${GNU_TARGET_NAME}
#                -P ${CMAKE_CURRENT_SOURCE_DIR}/br_real.cmake
        )
