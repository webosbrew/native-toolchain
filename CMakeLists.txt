cmake_minimum_required(VERSION 3.24)

project(buildroot_ports C)

if (NOT CMAKE_C_COMPILER_ID STREQUAL "GNU")
    message(FATAL_ERROR "To build the toolchain, you'll need GCC on your machine")
endif ()
if (NOT "$ENV{LANG}" STREQUAL "en_US.UTF-8")
    message(FATAL_ERROR "Please set LANG environment variable to `en_US.UTF-8`")
endif ()

set(CMAKE_C_STANDARD 11)

string(REGEX REPLACE ".*-" "" BUILDROOT_BUILD_ID "${BUILDROOT_RELEASE}")
set(GNU_TARGET_NAME "arm-webos-linux-gnueabi")

set(BUILDROOT_RELEASE "webos-71307ba")
set(BUILDROOT_SDK_NAME "${GNU_TARGET_NAME}_sdk-buildroot")

if (NOT DEFINED GNU_MIRROR)
    set(GNU_MIRROR "https://ftp.gnu.org/gnu")
endif ()

if (NOT DEFINED GCC_MIRROR)
    set(GCC_MIRROR "https://gcc.gnu.org/pub/gcc")
endif ()

if (NOT DEFINED BUILDROOT_DOWNLOADS)
    set(BUILDROOT_DOWNLOADS "https://github.com/openlgtv/buildroot-nc4/releases/download")
endif ()

if (NOT DEFINED CMAKE_INSTALL_PREFIX)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/dist")
endif ()
set(CMAKE_STAGING_PREFIX "${CMAKE_BINARY_DIR}/${BUILDROOT_SDK_NAME}")

if (NOT DEFINED CMAKE_C_COMPILER_TARGET)
    execute_process(COMMAND "${CMAKE_C_COMPILER}" "-v" ERROR_VARIABLE GCC_VERSION_INFO)
    string(REGEX REPLACE ".*Target: ([^\n]+).*" "\\1" CMAKE_C_COMPILER_TARGET "${GCC_VERSION_INFO}")
endif ()

include(FetchContent)
include(ExternalProject)

FetchContent_Declare(
        buildroot-nc4
        GIT_REPOSITORY "https://github.com/openlgtv/buildroot-nc4.git"
        GIT_TAG "${BUILDROOT_RELEASE}")

FetchContent_MakeAvailable(buildroot-nc4)

add_subdirectory(sysroot)
add_subdirectory(package)

install(DIRECTORY ${CMAKE_STAGING_PREFIX}/ DESTINATION ${CMAKE_INSTALL_PREFIX} USE_SOURCE_PERMISSIONS)

add_subdirectory(toolchain)
