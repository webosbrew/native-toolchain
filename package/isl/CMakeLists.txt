set(ISL_VERSION 0.24)

ExternalProject_Get_Property(gmp INSTALL_DIR)
set(GMP_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(isl DEPENDS gmp
        INSTALL_DIR "${CMAKE_STAGING_PREFIX}"
        URL "${GCC_MIRROR}/infrastructure/isl-${ISL_VERSION}.tar.bz2"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
            --with-gmp-prefix=<INSTALL_DIR>
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install-strip
        LOG_CONFIGURE TRUE
        LOG_BUILD TRUE
        LOG_INSTALL TRUE
        LOG_OUTPUT_ON_FAILURE TRUE
)

ExternalProject_Get_Property(isl INSTALL_DIR)
