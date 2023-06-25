br_get_var("package/gperf/gperf.mk" GPERF_VERSION GPERF_VERSION)

ExternalProject_Add(gperf
        URL "https://ftp.gnu.org/gnu/gperf/gperf-${GPERF_VERSION}.tar.gz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND  <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install)

ExternalProject_Get_Property(gperf INSTALL_DIR)

install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${CMAKE_INSTALL_PREFIX} USE_SOURCE_PERMISSIONS
        PATTERN src EXCLUDE PATTERN tmp EXCLUDE)