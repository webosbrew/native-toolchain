br_get_var("package/libtool/libtool.mk" LIBTOOL_VERSION LIBTOOL_VERSION)

ExternalProject_Get_Property(m4 INSTALL_DIR)
set(M4_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(libtool DEPENDS autoconf m4
        URL "https://ftp.gnu.org/gnu/libtool/libtool-${LIBTOOL_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
            M4=${M4_INSTALL_DIR}/bin/m4 MAKEINFO=true
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install)

ExternalProject_Get_Property(libtool INSTALL_DIR)

install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${HOST_DIR} USE_SOURCE_PERMISSIONS
        PATTERN src EXCLUDE PATTERN tmp EXCLUDE)