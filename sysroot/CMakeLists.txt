set(SYSROOT "${CMAKE_STAGING_PREFIX}/${GNU_TARGET_NAME}/sysroot")

if (APPLE OR BSD)
    set(PATCH_RELOCATE_SDK "COMMAND" "patch" "${CMAKE_STAGING_PREFIX}/relocate-sdk.sh"
            "${CMAKE_CURRENT_SOURCE_DIR}/relocate-sdk.patch")
endif ()

ExternalProject_Add(sysroot
        INSTALL_DIR "${CMAKE_STAGING_PREFIX}"
        URL "${BUILDROOT_DOWNLOADS}/${BUILDROOT_RELEASE}/${BUILDROOT_SDK_NAME}.tar.gz"
        DOWNLOAD_NO_EXTRACT TRUE
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ${CMAKE_COMMAND} -E chdir ${CMAKE_BINARY_DIR} tar xf <DOWNLOADED_FILE>
                --exclude "${BUILDROOT_SDK_NAME}/${GNU_TARGET_NAME}/sysroot/usr/share/doc"
                --exclude "${BUILDROOT_SDK_NAME}/${GNU_TARGET_NAME}/sysroot/usr/share/i18n"
                --exclude "${BUILDROOT_SDK_NAME}/${GNU_TARGET_NAME}/sysroot/usr/share/locale"
                --exclude "${BUILDROOT_SDK_NAME}/${GNU_TARGET_NAME}/sysroot/usr/share/man"
                --exclude "${BUILDROOT_SDK_NAME}/${GNU_TARGET_NAME}/sysroot/usr/share/terminfo"
                --exclude "${BUILDROOT_SDK_NAME}/${GNU_TARGET_NAME}/sysroot/usr/share/zoneinfo"
                "${BUILDROOT_SDK_NAME}/${GNU_TARGET_NAME}/sysroot"
                "${BUILDROOT_SDK_NAME}/share/buildroot"
                "${BUILDROOT_SDK_NAME}/environment-setup"
                "${BUILDROOT_SDK_NAME}/relocate-sdk.sh"
            ${PATCH_RELOCATE_SDK}
            COMMAND "${CMAKE_STAGING_PREFIX}/relocate-sdk.sh"
        LOG_CONFIGURE TRUE
        LOG_BUILD TRUE
        LOG_INSTALL TRUE
        LOG_OUTPUT_ON_FAILURE TRUE)
