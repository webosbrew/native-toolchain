br_get_var("package/mpc/mpc.mk" MPC_VERSION MPC_VERSION)

ExternalProject_Get_Property(gmp INSTALL_DIR)
set(GMP_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Get_Property(mpfr INSTALL_DIR)
set(MPFR_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(mpc DEPENDS gmp mpfr
        URL "${GCC_MIRROR}/infrastructure/mpc-${MPC_VERSION}.tar.gz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
            --with-gmp=${GMP_INSTALL_DIR} --with-mpfr=${MPFR_INSTALL_DIR}
        BUILD_COMMAND make -j${NPROC}
        INSTALL_COMMAND make install)
