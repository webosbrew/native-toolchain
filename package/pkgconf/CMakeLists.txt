br_get_var("package/pkgconf/pkgconf.mk" PKGCONF_VERSION PKGCONF_VERSION)

set(SYSROOT "${CMAKE_STAGING_PREFIX}/${GNU_TARGET_NAME}/sysroot")

file(GLOB PKGCONF_PATCHES "${buildroot-nc4_SOURCE_DIR}/package/pkgconf/*.patch")
list(TRANSFORM PKGCONF_PATCHES PREPEND "COMMAND;patch;-p1;<;" OUTPUT_VARIABLE PKGCONF_PATCH_COMMANDS)

ExternalProject_Add(pkgconf DEPENDS autoconf automake sysroot
        INSTALL_DIR "${CMAKE_STAGING_PREFIX}"
        URL "https://distfiles.dereferenced.org/pkgconf/pkgconf-${PKGCONF_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        PATCH_COMMAND ${PKGCONF_PATCH_COMMANDS}
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
            --with-sysroot=${SYSROOT}
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install-strip
        LOG_CONFIGURE TRUE
        LOG_BUILD TRUE
        LOG_INSTALL TRUE
        LOG_OUTPUT_ON_FAILURE TRUE
)

ExternalProject_Get_Property(pkgconf INSTALL_DIR)

set(STAGING_SUBDIR "${GNU_TARGET_NAME}/sysroot")
set(STATIC "")

configure_file(${buildroot-nc4_SOURCE_DIR}/package/pkgconf/pkg-config.in ${CMAKE_CURRENT_BINARY_DIR}/pkg-config @ONLY)
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/pkg-config DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)