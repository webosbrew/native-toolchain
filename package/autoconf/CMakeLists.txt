br_get_var("package/autoconf/autoconf.mk" AUTOCONF_VERSION AUTOCONF_VERSION)

file(GLOB AUTOCONF_PATCHES "${buildroot-nc4_SOURCE_DIR}/package/autoconf/*.patch")
list(TRANSFORM AUTOCONF_PATCHES PREPEND "COMMAND;patch;-p1;<;" OUTPUT_VARIABLE AUTOCONF_PATCH_COMMANDS)

ExternalProject_Get_Property(m4 INSTALL_DIR)
set(M4_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(autoconf DEPENDS m4
        URL "https://ftp.gnu.org/gnu/autoconf/autoconf-${AUTOCONF_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        PATCH_COMMAND ${AUTOCONF_PATCH_COMMANDS}
        CONFIGURE_COMMAND EMACS="no" ac_cv_path_M4=${M4_INSTALL_DIR}/bin/m4 ac_cv_prog_gnu_m4_gnu=no
            <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install)

ExternalProject_Get_Property(autoconf INSTALL_DIR)

install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${HOST_DIR} USE_SOURCE_PERMISSIONS
        PATTERN src EXCLUDE PATTERN tmp EXCLUDE)
