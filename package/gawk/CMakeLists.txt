br_get_var("package/gawk/gawk.mk" GAWK_VERSION GAWK_VERSION)

file(GLOB GAWK_PATCHES "${buildroot-nc4_SOURCE_DIR}/package/gawk/*.patch")
list(TRANSFORM GAWK_PATCHES PREPEND "COMMAND;patch;-p1;<;" OUTPUT_VARIABLE GAWK_PATCH_COMMANDS)

ExternalProject_Get_Property(mpfr INSTALL_DIR)
set(MPFR_INSTALL_DIR ${INSTALL_DIR})

ExternalProject_Add(gawk DEPENDS mpfr
        URL "https://ftp.gnu.org/gnu/gawk/gawk-${GAWK_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        PATCH_COMMAND ${GAWK_PATCH_COMMANDS}
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc
            --with-mpfr=${MPFR_INSTALL_DIR}
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install)

ExternalProject_Get_Property(gawk INSTALL_DIR)

install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${CMAKE_INSTALL_PREFIX} USE_SOURCE_PERMISSIONS
        PATTERN src EXCLUDE PATTERN tmp EXCLUDE)
install(CODE "file(CREATE_LINK gawk ${CMAKE_INSTALL_PREFIX}/bin/awk SYMBOLIC)")