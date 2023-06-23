set(ISL_VERSION 0.24)

set(PREFIX ${BUILDROOT_PORT_PREFIX})

ExternalProject_Add(isl DEPENDS gmp
        URL "${GCC_MIRROR}/infrastructure/isl-${ISL_VERSION}.tar.bz2"
        DOWNLOAD_EXTRACT_TIMESTAMP FALSE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=${PREFIX} --sysconfdir=${PREFIX}/etc --with-gmp=${PREFIX}
        BUILD_COMMAND make -j${NPROC}
        INSTALL_COMMAND make install)
