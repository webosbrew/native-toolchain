add_executable(toolchain-wrapper ${buildroot-nc4_SOURCE_DIR}/toolchain/toolchain-wrapper.c)
target_compile_definitions(toolchain-wrapper PUBLIC BR_CROSS_PATH_SUFFIX=".br_real"
        BR_SYSROOT="%s/arm-webos-linux-gnueabi/sysroot")
if (APPLE OR BSD)
    target_compile_definitions(toolchain-wrapper PUBLIC program_invocation_short_name=getprogname())
endif()