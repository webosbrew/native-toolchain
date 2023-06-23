br_get_var("package/mpc/mpc.mk" MPC_VERSION MPC_VERSION)

set(PREFIX ${BUILDROOT_PORT_PREFIX})

ExternalProject_Add(mpc DEPENDS gmp mpfr
        URL "${GCC_MIRROR}/infrastructure/mpc-${MPC_VERSION}.tar.gz"
        DOWNLOAD_EXTRACT_TIMESTAMP FALSE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=${PREFIX} --sysconfdir=${PREFIX}/etc --with-gmp=${PREFIX}
        BUILD_COMMAND make -j${NPROC}
        INSTALL_COMMAND make install)
