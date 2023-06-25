set(BINUTILS_VERSION 2.38)

set(SYSROOT "${HOST_DIR}/${GNU_TARGET_NAME}/sysroot")

ExternalProject_Add(binutils DEPENDS sysroot
        URL "https://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS_VERSION}.tar.bz2"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc --disable-multilib
            --disable-werror --target=${GNU_TARGET_NAME} --disable-shared --enable-static --with-sysroot=${SYSROOT}
            --enable-poison-system-directories --without-debuginfod --enable-plugins --enable-lto --disable-sim
            --disable-gdb --enable-gold  --disable-gprofng
        BUILD_COMMAND $(MAKE) MAKEINFO=true
        INSTALL_COMMAND $(MAKE) install-strip MAKEINFO=true)

ExternalProject_Get_Property(binutils INSTALL_DIR)

install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${CMAKE_INSTALL_PREFIX} USE_SOURCE_PERMISSIONS
        PATTERN src EXCLUDE PATTERN tmp EXCLUDE)