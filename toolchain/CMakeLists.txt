add_executable(toolchain-wrapper ${buildroot-nc4_SOURCE_DIR}/toolchain/toolchain-wrapper.c)
target_compile_definitions(toolchain-wrapper PUBLIC BR_CROSS_PATH_SUFFIX=".br_real"
        BR_SYSROOT="%s/arm-webos-linux-gnueabi/sysroot")

if (APPLE OR BSD)
    target_compile_definitions(toolchain-wrapper PUBLIC "program_invocation_short_name=getprogname()")
endif ()

add_dependencies(toolchain-wrapper gcc)

install(TARGETS toolchain-wrapper DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

ExternalProject_Get_Property(gcc INSTALL_DIR)

install(CODE "execute_process(COMMAND ${CMAKE_COMMAND} -DBINDIR=${CMAKE_INSTALL_PREFIX}/bin
    -DGNU_TARGET_NAME=${GNU_TARGET_NAME} -P ${CMAKE_CURRENT_SOURCE_DIR}/toolchain-wrapper-links.cmake)")

if (APPLE OR BSD)
    install(CODE "execute_process(COMMAND bash ${CMAKE_CURRENT_SOURCE_DIR}/fix-rpath.macos.sh
        ${CMAKE_STAGING_PREFIX}/lib WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX})")
endif ()