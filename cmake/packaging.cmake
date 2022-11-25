
include(CMakePackageConfigHelpers)
include(GNUInstallDirs)
file(WRITE "${CMAKE_BINARY_DIR}/config.cmake.in" [=[
@PACKAGE_INIT@
include("${CMAKE_CURRENT_LIST_DIR}/@PROJECT_NAME@-targets.cmake")
check_required_components(@PROJECT_NAME@)
]=])
foreach(EXTRA ${PACKAGING_EXTRAS})
    file(APPEND "${CMAKE_BINARY_DIR}/config.cmake.in" "${EXTRA}\n")
endforeach()
configure_package_config_file(${CMAKE_BINARY_DIR}/config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}
    NO_SET_AND_CHECK_MACRO)
write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion)
install(
    FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
    DESTINATION
    ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME})
install(TARGETS ${PROJECT_NAME} EXPORT ${PROJECT_NAME}-targets)
install(EXPORT ${PROJECT_NAME}-targets DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME} NAMESPACE ${PROJECT_NAME}::)
install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/ TYPE INCLUDE)
