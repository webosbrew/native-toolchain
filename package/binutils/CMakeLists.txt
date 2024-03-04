set(BINUTILS_VERSION 2.38)

file(GLOB BINUTILS_PATCHES "${CMAKE_CURRENT_SOURCE_DIR}/*.patch")

list(TRANSFORM BINUTILS_PATCHES PREPEND "COMMAND;patch;-p1;<;" OUTPUT_VARIABLE BINUTILS_PATCH_COMMANDS)

set(SYSROOT "${CMAKE_STAGING_PREFIX}/${GNU_TARGET_NAME}/sysroot")

ExternalProject_Add(binutils DEPENDS sysroot
        INSTALL_DIR "${CMAKE_STAGING_PREFIX}"
        URL "${GNU_MIRROR}/binutils/binutils-${BINUTILS_VERSION}.tar.bz2"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        PATCH_COMMAND ${BINUTILS_PATCH_COMMANDS}
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc --disable-multilib
            --disable-werror --target=${GNU_TARGET_NAME} --disable-shared --enable-static --with-sysroot=${SYSROOT}
            --enable-poison-system-directories --without-debuginfod --enable-plugins --enable-lto --disable-sim
            --disable-gdb --enable-gold  --disable-gprofng
        BUILD_COMMAND $(MAKE) MAKEINFO=true
        INSTALL_COMMAND $(MAKE) install-strip MAKEINFO=true
        LOG_CONFIGURE TRUE
        LOG_BUILD TRUE
        LOG_INSTALL TRUE
        LOG_OUTPUT_ON_FAILURE TRUE
)

ExternalProject_Get_Property(binutils INSTALL_DIR)