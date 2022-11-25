# Don't set the MSVC compiler.. This works when opening the folder in Visual Studio
include(${CMAKE_CURRENT_LIST_DIR}/vcvars.cmake)

find_program(CMAKE_C_COMPILER   cl REQUIRED HINTS ${MSVC_ENV_Path})
find_program(CMAKE_CXX_COMPILER cl REQUIRED HINTS ${MSVC_ENV_Path})
find_program(CMAKE_MT           mt REQUIRED HINTS ${MSVC_ENV_Path})
find_program(CMAKE_RC_COMPILER  rc REQUIRED HINTS ${MSVC_ENV_Path})

set(CMAKE_CXX_COMPILER_FRONTEND_VARIANT MSVC)
set(CMAKE_C_COMPILER_FRONTEND_VARIANT MSVC)

list(APPEND CMAKE_C_STANDARD_INCLUDE_DIRECTORIES ${MSVC_ENV_INCLUDE})
list(REMOVE_DUPLICATES CMAKE_C_STANDARD_INCLUDE_DIRECTORIES)
set(CMAKE_C_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_C_STANDARD_INCLUDE_DIRECTORIES} CACHE STRING "")

list(APPEND CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${MSVC_ENV_INCLUDE})
list(REMOVE_DUPLICATES CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES)
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES} CACHE STRING "")

list(APPEND CMAKE_RC_STANDARD_INCLUDE_DIRECTORIES ${MSVC_ENV_INCLUDE})
list(REMOVE_DUPLICATES CMAKE_RC_STANDARD_INCLUDE_DIRECTORIES)
set(CMAKE_RC_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_RC_STANDARD_INCLUDE_DIRECTORIES} CACHE STRING "")

foreach(libpath ${MSVC_ENV_LIBPATH} ${MSVC_ENV_LIB})
    set(CMAKE_SHARED_LINKER_FLAGS_INIT "${CMAKE_SHARED_LINKER_FLAGS_INIT} \"/LIBPATH:${libpath}\"")
    set(CMAKE_MODULE_LINKER_FLAGS_INIT "${CMAKE_MODULE_LINKER_FLAGS_INIT} \"/LIBPATH:${libpath}\"")
    set(CMAKE_EXE_LINKER_FLAGS_INIT    "${CMAKE_EXE_LINKER_FLAGS_INIT}    \"/LIBPATH:${libpath}\"")
endforeach()

list(APPEND LINK_DIRECTORIES $ENV{LIB} $ENV{LIBPATH})
list(REMOVE_DUPLICATES LINK_DIRECTORIES)
set(LINK_DIRECTORIES ${LINK_DIRECTORIES} CACHE STRING "")
link_directories(BEFORE ${LINK_DIRECTORIES})

list(APPEND CMAKE_TRY_COMPILE_PLATFORM_VARIABLES
    MSVC_ENV_INCLUDE
    MSVC_ENV_LIBPATH
    MSVC_ENV_VAR_NAMES
    MSVC_ENV_Path
    MSVC_ENV_LIB
)