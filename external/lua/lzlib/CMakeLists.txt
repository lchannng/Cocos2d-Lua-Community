cmake_minimum_required(VERSION 3.6)

set(lib_name lzlib)
set(target_name ext_${lib_name})

project(${lib_name})

set(${target_name}_src
  lua_zlib.c
)

add_library(${target_name} STATIC
  ${${target_name}_src}
)

target_include_directories(${target_name}
  PRIVATE ${LUA_INCLUDE_DIR}

  # zlib from vcpkg
  PRIVATE ${ZLIB_INCLUDE_DIR}
)

# target_link_libraries(${target_name} PRIVATE ZLIB:ZLIB)

set_target_properties(${target_name}
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    FOLDER "External/lua"
)

