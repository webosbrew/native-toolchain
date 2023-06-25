set(ISL_VERSION 0.24)

ExternalProject_Get_Property(gmp INSTALL_DIR)
set(GMP_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(isl DEPENDS gmp
        URL "${GCC_MIRROR}/infrastructure/isl-${ISL_VERSION}.tar.bz2"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
            --with-gmp-prefix=${GMP_INSTALL_DIR}
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install)

ExternalProject_Get_Property(isl INSTALL_DIR)

install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${CMAKE_INSTALL_PREFIX} USE_SOURCE_PERMISSIONS
        PATTERN src EXCLUDE PATTERN tmp EXCLUDE)