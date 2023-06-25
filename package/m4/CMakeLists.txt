br_get_var("package/m4/m4.mk" M4_VERSION M4_VERSION)

ExternalProject_Get_Property(gperf INSTALL_DIR)
set(GPERF_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(m4 DEPENDS gperf
        URL "https://ftp.gnu.org/gnu/m4/m4-${M4_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc --disable-nls
        BUILD_COMMAND $(MAKE) GPERF=${GPERF_INSTALL_DIR}/bin/gperf HELP2MAN=true
        INSTALL_COMMAND $(MAKE) install HELP2MAN=true)

ExternalProject_Get_Property(m4 INSTALL_DIR)

install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${HOST_DIR} USE_SOURCE_PERMISSIONS
        PATTERN src EXCLUDE PATTERN tmp EXCLUDE)