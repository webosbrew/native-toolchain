br_get_var("package/mpfr/mpfr.mk" MPFR_VERSION MPFR_VERSION)

set(PREFIX ${BUILDROOT_PORT_PREFIX})

ExternalProject_Add(mpfr DEPENDS gmp
        URL "${GCC_MIRROR}/infrastructure/mpfr-${MPFR_VERSION}.tar.bz2"
        DOWNLOAD_EXTRACT_TIMESTAMP FALSE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=${PREFIX} --sysconfdir=${PREFIX}/etc --with-gmp=${PREFIX}
        BUILD_COMMAND make -j${NPROC}
        INSTALL_COMMAND make install)
