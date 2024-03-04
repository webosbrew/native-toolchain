br_get_var("package/gperf/gperf.mk" GPERF_VERSION GPERF_VERSION)

ExternalProject_Add(gperf
        INSTALL_DIR "${CMAKE_STAGING_PREFIX}"
        URL "${GNU_MIRROR}/gperf/gperf-${GPERF_VERSION}.tar.gz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND  <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install
        LOG_CONFIGURE TRUE
        LOG_BUILD TRUE
        LOG_INSTALL TRUE
        LOG_OUTPUT_ON_FAILURE TRUE
)

ExternalProject_Get_Property(gperf INSTALL_DIR)
