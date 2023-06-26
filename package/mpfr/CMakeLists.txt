br_get_var("package/mpfr/mpfr.mk" MPFR_VERSION MPFR_VERSION)

ExternalProject_Get_Property(gmp INSTALL_DIR)
set(GMP_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(mpfr DEPENDS gmp
        INSTALL_DIR "${CMAKE_STAGING_PREFIX}"
        URL "${GCC_MIRROR}/infrastructure/mpfr-${MPFR_VERSION}.tar.bz2"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
            --with-gmp=<INSTALL_DIR>
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install-strip)

ExternalProject_Get_Property(mpfr INSTALL_DIR)