br_get_var("package/mpfr/mpfr.mk" MPFR_VERSION MPFR_VERSION)

ExternalProject_Get_Property(gmp INSTALL_DIR)
set(GMP_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(mpfr DEPENDS gmp
        URL "${GCC_MIRROR}/infrastructure/mpfr-${MPFR_VERSION}.tar.bz2"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
            --with-gmp=${GMP_INSTALL_DIR}
        BUILD_COMMAND make -j${NPROC}
        INSTALL_COMMAND make install)
