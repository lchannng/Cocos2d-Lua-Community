cmake_minimum_required(VERSION 3.6)

set(lib_name lua54)
set(target_name ext_${lib_name})
project(${lib_name})

add_library(${target_name} STATIC onelua.c)
target_include_directories(${target_name} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_definitions(${target_name} PRIVATE MAKE_LIB)
set_target_properties(${target_name}
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    FOLDER "External/lua"
)

# include(../../cmake/CocosExternalConfig.cmake)

# if(WINDOWS)
#   add_library(${target_name} SHARED IMPORTED GLOBAL)
# else()
#   add_library(${target_name} STATIC IMPORTED GLOBAL)
# endif()
# 
# set_target_properties(${target_name} PROPERTIES
#   INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR}/include"
# )
# if(WINDOWS)
#   set_target_properties(${target_name} PROPERTIES
#     IMPORTED_LOCATION "${platform_spec_path}/lua51.dll"
#     IMPORTED_IMPLIB "${platform_spec_path}/lua51.lib"
#   )
# else()
#   set_target_properties(${target_name} PROPERTIES
#     IMPORTED_LOCATION "${platform_spec_path}/lib${lib_name}.a"
#   )
# endif()
