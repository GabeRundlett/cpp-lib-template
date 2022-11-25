cmake_minimum_required(VERSION 3.21)
execute_process(COMMAND vcpkg x-update-baseline)
include(cmake/warnings.cmake)
include(cmake/static_analysis.cmake)

project(my-lib VERSION 0.1.0)

if(BUILD_SHARED_LIBS)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
endif()

add_library(${PROJECT_NAME} "src/core.cpp")
add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_20)
target_include_directories(${PROJECT_NAME}
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
set_project_warnings(${PROJECT_NAME})

include(GenerateExportHeader)
generate_export_header(${PROJECT_NAME})

find_package(fmt CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PUBLIC fmt::fmt)
# This is necessary for exporting the acquisition of the fmt
# package to installation. See the packaging.cmake file to see
# how this variable is used.
list(APPEND PACKAGING_EXTRAS "find_package(fmt CONFIG REQUIRED)")

if(ENABLE_TESTS)
    add_subdirectory(tests)
endif()

include(cmake/packaging.cmake)
