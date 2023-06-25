cmake_minimum_required(VERSION 3.24)

project(buildroot_ports C)

if (NOT CMAKE_C_COMPILER_ID STREQUAL "GNU")
    message(FATAL_ERROR "To build the toolchain, you'll need GCC on your machine")
endif ()

set(CMAKE_C_STANDARD 11)

string(REGEX REPLACE ".*-" "" BUILDROOT_BUILD_ID "${BUILDROOT_RELEASE}")
set(GNU_TARGET_NAME "arm-webos-linux-gnueabi")

set(BUILDROOT_RELEASE "webos-71307ba")
set(BUILDROOT_SDK_NAME "${GNU_TARGET_NAME}_sdk-buildroot")

set(HOST_DIR "${CMAKE_BINARY_DIR}/${BUILDROOT_SDK_NAME}")
set(BUILDROOT_PORT_DOWNLOADS "${CMAKE_BINARY_DIR}/downloads")

set(GCC_MIRROR "http://ftp.tsukuba.wide.ad.jp/software/gcc")

set(CMAKE_INSTALL_PREFIX ${HOST_DIR})

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
add_subdirectory(toolchain)
