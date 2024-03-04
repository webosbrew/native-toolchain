br_get_var("package/gmp/gmp.mk" GMP_VERSION GMP_VERSION)

ExternalProject_Get_Property(m4 INSTALL_DIR)
set(M4_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(gmp DEPENDS m4
        INSTALL_DIR "${CMAKE_STAGING_PREFIX}"
        URL "${GCC_MIRROR}/infrastructure/gmp-${GMP_VERSION}.tar.bz2"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
            M4=${M4_INSTALL_DIR}/bin/m4
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install-strip
        LOG_CONFIGURE TRUE
        LOG_BUILD TRUE
        LOG_INSTALL TRUE
        LOG_OUTPUT_ON_FAILURE TRUE
)

ExternalProject_Get_Property(gmp INSTALL_DIR)
