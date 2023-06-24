br_get_var("package/gperf/gperf.mk" GPERF_VERSION GPERF_VERSION)

ExternalProject_Add(gperf
        URL "https://ftp.gnu.org/gnu/gperf/gperf-${GPERF_VERSION}.tar.gz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND  <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
        BUILD_COMMAND make
        INSTALL_COMMAND make install)
