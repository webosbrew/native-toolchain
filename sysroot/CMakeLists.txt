set(TARBALL_NAME "${BUILDROOT_TRIPLE}_sdk-buildroot")

set(PREFIX ${BUILDROOT_PORT_PREFIX})

ExternalProject_Add(sysroot
        URL "https://github.com/openlgtv/buildroot-nc4/releases/download/${BUILDROOT_RELEASE}/${TARBALL_NAME}.tar.gz"
        DOWNLOAD_NO_EXTRACT TRUE
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ${CMAKE_COMMAND} -E tar xf <DOWNLOADED_FILE> "${TARBALL_NAME}/${BUILDROOT_TRIPLE}/sysroot"
            COMMAND ${CMAKE_COMMAND} -E rename "${TARBALL_NAME}/${BUILDROOT_TRIPLE}" "${PREFIX}/${BUILDROOT_TRIPLE}")
