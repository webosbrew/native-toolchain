#!/usr/bin/env cmake

set(STAGING_SUBDIR "${GNU_TARGET_NAME}/sysroot")
set(STATIC "")

configure_file(${BR_SOURCE_DIR}/package/pkgconf/pkg-config.in ${HOST_DIR}/bin/pkg-config @ONLY)