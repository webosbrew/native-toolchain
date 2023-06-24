set(ISL_VERSION 0.24)

ExternalProject_Get_Property(gmp INSTALL_DIR)
set(GMP_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(isl DEPENDS gmp
        URL "${GCC_MIRROR}/infrastructure/isl-${ISL_VERSION}.tar.bz2"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
            --with-gmp-prefix=${GMP_INSTALL_DIR}
        BUILD_COMMAND make -j${NPROC}
        INSTALL_COMMAND make install)
