br_get_var("package/wayland/wayland.mk" HOST_WAYLAND_VERSION WAYLAND_VERSION)

ExternalProject_Add(wayland
        INSTALL_DIR "${CMAKE_STAGING_PREFIX}"
        URL "http://wayland.freedesktop.org/releases/wayland-${WAYLAND_VERSION}.tar.xz"
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        PATCH_COMMAND ${WAYLAND_PATCH_COMMANDS}
        CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --sysconfdir=<INSTALL_DIR>/etc 
            --disable-libraries --disable-documentation
        BUILD_COMMAND $(MAKE)
        INSTALL_COMMAND $(MAKE) install-strip)

ExternalProject_Get_Property(wayland INSTALL_DIR)