br_get_var("package/autoconf-archive/autoconf-archive.mk" AUTOCONF_ARCHIVE_VERSION AUTOCONF_ARCHIVE_VERSION)

ExternalProject_Get_Property(autoconf INSTALL_DIR)
set(AUTOCONF_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(autoconf-archive DEPENDS autoconf m4
        INSTALL_DIR "${CMAKE_STAGING_PREFIX}"
        URL "${GNU_MIRROR}/autoconf-archive/autoconf-archive-${AUTOCONF_ARCHIVE_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
            AUTOCONF=${AUTOCONF_INSTALL_DIR}/bin/autoconf AUTOHEADER=${AUTOCONF_INSTALL_DIR}/bin/autoheader
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install-strip
        LOG_CONFIGURE TRUE
        LOG_BUILD TRUE
        LOG_INSTALL TRUE
        LOG_OUTPUT_ON_FAILURE TRUE
)

ExternalProject_Get_Property(autoconf-archive INSTALL_DIR)