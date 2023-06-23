br_get_var("package/gmp/gmp.mk" GMP_VERSION GMP_VERSION)

set(PREFIX ${BUILDROOT_PORT_PREFIX})

ExternalProject_Add(gmp
        URL "${GCC_MIRROR}/infrastructure/gmp-${GMP_VERSION}.tar.bz2"
        DOWNLOAD_EXTRACT_TIMESTAMP FALSE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=${PREFIX} --sysconfdir=${PREFIX}/etc
        BUILD_COMMAND make -j${NPROC}
        INSTALL_COMMAND make install)
