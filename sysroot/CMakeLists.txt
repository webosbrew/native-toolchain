set(PREFIX ${HOST_DIR})
set(SYSROOT "${PREFIX}/${GNU_TARGET_NAME}/sysroot")

if (APPLE OR BSD)
    set(PATCH_RELOCATE_SDK "COMMAND" "patch" "${HOST_DIR}/relocate-sdk.sh"
            "${CMAKE_CURRENT_SOURCE_DIR}/relocate-sdk.patch")
endif ()

ExternalProject_Add(sysroot
        URL "https://github.com/openlgtv/buildroot-nc4/releases/download/${BUILDROOT_RELEASE}/${BUILDROOT_SDK_NAME}.tar.gz"
        DOWNLOAD_NO_EXTRACT TRUE
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_BINARY_DIR} tar xf <DOWNLOADED_FILE>
                "${BUILDROOT_SDK_NAME}/${GNU_TARGET_NAME}/sysroot"
                "${BUILDROOT_SDK_NAME}/share/buildroot"
                "${BUILDROOT_SDK_NAME}/environment-setup"
                "${BUILDROOT_SDK_NAME}/relocate-sdk.sh" || true
            ${PATCH_RELOCATE_SDK}
            COMMAND "${HOST_DIR}/relocate-sdk.sh")
