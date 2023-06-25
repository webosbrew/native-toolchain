br_get_var("package/automake/automake.mk" AUTOMAKE_VERSION AUTOMAKE_VERSION)

file(GLOB AUTOMAKE_PATCHES "${buildroot-nc4_SOURCE_DIR}/package/automake/*.patch")
list(TRANSFORM AUTOMAKE_PATCHES PREPEND "COMMAND;patch;-p1;<;" OUTPUT_VARIABLE AUTOMAKE_PATCH_COMMANDS)

ExternalProject_Get_Property(autoconf INSTALL_DIR)
set(AUTOCONF_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(automake DEPENDS autoconf autoconf-archive
        URL "https://ftp.gnu.org/gnu/automake/automake-${AUTOMAKE_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        PATCH_COMMAND ${AUTOMAKE_PATCH_COMMANDS}
        CONFIGURE_COMMAND
            COMMAND ${CMAKE_COMMAND} -E make_directory ${HOST_DIR}/share/aclocal
            COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
                AUTOCONF=${AUTOCONF_INSTALL_DIR}/bin/autoconf AUTOHEADER=${AUTOCONF_INSTALL_DIR}/bin/autoheader
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install)

ExternalProject_Get_Property(automake INSTALL_DIR)

install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${HOST_DIR} USE_SOURCE_PERMISSIONS
        PATTERN src EXCLUDE PATTERN tmp EXCLUDE)