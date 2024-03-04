br_get_var("package/gawk/gawk.mk" GAWK_VERSION GAWK_VERSION)

file(GLOB GAWK_PATCHES "${buildroot-nc4_SOURCE_DIR}/package/gawk/*.patch")
list(TRANSFORM GAWK_PATCHES PREPEND "COMMAND;patch;-p1;<;" OUTPUT_VARIABLE GAWK_PATCH_COMMANDS)

ExternalProject_Get_Property(mpfr INSTALL_DIR)
set(MPFR_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(gawk DEPENDS mpfr
        INSTALL_DIR "${CMAKE_STAGING_PREFIX}"
        URL "${GNU_MIRROR}/gawk/gawk-${GAWK_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        PATCH_COMMAND ${GAWK_PATCH_COMMANDS}
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install-strip
        LOG_CONFIGURE TRUE
        LOG_BUILD TRUE
        LOG_INSTALL TRUE
        LOG_OUTPUT_ON_FAILURE TRUE
)

ExternalProject_Get_Property(gawk INSTALL_DIR)

install(CODE "file(CREATE_LINK gawk ${CMAKE_INSTALL_PREFIX}/bin/awk SYMBOLIC)")