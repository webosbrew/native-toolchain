set(PREFIX ${HOST_DIR})
set(SYSROOT "${PREFIX}/${GNU_TARGET_NAME}/sysroot")

ExternalProject_Add(sysroot
        URL "https://github.com/openlgtv/buildroot-nc4/releases/download/${BUILDROOT_RELEASE}/${BUILDROOT_SDK_NAME}.tar.gz"
        DOWNLOAD_NO_EXTRACT TRUE
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_BINARY_DIR} tar xf <DOWNLOADED_FILE>
                "${BUILDROOT_SDK_NAME}/${GNU_TARGET_NAME}/sysroot"
                "${BUILDROOT_SDK_NAME}/share/buildroot"
                "${BUILDROOT_SDK_NAME}/relocate-sdk.sh"
            COMMAND "${HOST_DIR}/relocate-sdk.sh")
