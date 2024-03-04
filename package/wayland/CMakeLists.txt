br_get_var("package/wayland/wayland.mk" HOST_WAYLAND_VERSION WAYLAND_VERSION)

if (APPLE OR BSD)
    list(APPEND WAYLAND_PATCHES "${CMAKE_CURRENT_SOURCE_DIR}/fix-dtddata.macos.patch")
endif ()

list(TRANSFORM WAYLAND_PATCHES PREPEND "COMMAND;patch;-p1;<;" OUTPUT_VARIABLE WAYLAND_PATCH_COMMANDS)

ExternalProject_Add(wayland
        INSTALL_DIR "${CMAKE_STAGING_PREFIX}"
        URL "http://wayland.freedesktop.org/releases/wayland-${WAYLAND_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        PATCH_COMMAND ${WAYLAND_PATCH_COMMANDS}
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc 
            --disable-libraries --disable-documentation
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install-strip
        LOG_CONFIGURE TRUE
        LOG_BUILD TRUE
        LOG_INSTALL TRUE
        LOG_OUTPUT_ON_FAILURE TRUE
)

ExternalProject_Get_Property(wayland INSTALL_DIR)