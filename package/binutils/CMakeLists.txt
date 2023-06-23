set(BINUTILS_VERSION 2.38)

set(PREFIX "${BUILDROOT_PORT_PREFIX}")
set(SYSROOT "${PREFIX}/${BUILDROOT_TRIPLE}/sysroot")

ExternalProject_Add(binutils DEPENDS sysroot
        URL "https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.bz2"
        DOWNLOAD_EXTRACT_TIMESTAMP FALSE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=${PREFIX} --sysconfdir=${PREFIX}/etc --disable-multilib
            --disable-werror --target=${BUILDROOT_TRIPLE} --disable-shared --enable-static --with-sysroot=${SYSROOT}
            --enable-poison-system-directories --without-debuginfod --enable-plugins --enable-lto --disable-sim
            --disable-gdb --enable-gold  --disable-gprofng
        BUILD_COMMAND make -j${NPROC}
        INSTALL_COMMAND make install)
