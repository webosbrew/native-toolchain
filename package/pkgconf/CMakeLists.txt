br_get_var("package/pkgconf/pkgconf.mk" PKGCONF_VERSION PKGCONF_VERSION)

set(SYSROOT "${HOST_DIR}/${GNU_TARGET_NAME}/sysroot")

file(GLOB PKGCONF_PATCHES "${buildroot-nc4_SOURCE_DIR}/package/pkgconf/*.patch")
list(TRANSFORM PKGCONF_PATCHES PREPEND "COMMAND;patch;-p1;<;" OUTPUT_VARIABLE PKGCONF_PATCH_COMMANDS)

ExternalProject_Add(pkgconf DEPENDS autoconf automake sysroot
        URL "https://distfiles.dereferenced.org/pkgconf/pkgconf-${PKGCONF_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        PATCH_COMMAND ${PKGCONF_PATCH_COMMANDS}
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
            --with-sysroot=${SYSROOT}
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install
        )

ExternalProject_Get_Property(pkgconf INSTALL_DIR)

install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${CMAKE_INSTALL_PREFIX} USE_SOURCE_PERMISSIONS
        PATTERN src EXCLUDE PATTERN tmp EXCLUDE)
install(CODE "execute_process(COMMAND ${CMAKE_COMMAND} -DGNU_TARGET_NAME=${GNU_TARGET_NAME}
    -DBR_SOURCE_DIR=${buildroot-nc4_SOURCE_DIR} -DHOST_DIR=${HOST_DIR}
    -P ${CMAKE_CURRENT_SOURCE_DIR}/pkg-config.cmake)")