cmake_minimum_required(VERSION 3.6)
project(external)

option(BUILD_EXT_BOX2D "Build with internal Box2D support" ON)
option(BUILD_EXT_CHIPMUNK "Build with internal chipmunk support" ON)
option(BUILD_EXT_FREETYPE2 "Build with internal freetype2 support" ON)
option(BUILD_EXT_RECAST "Build with internal recast support" ON)
option(BUILD_EXT_BULLET "Build with internal bullet support" ON)
option(BUILD_EXT_JPEG "Build with internal jpeg support" ON)
option(BUILD_EXT_OPENSSL "Build with internal openssl support" ON)
option(BUILD_EXT_WEBP "Build with internal webp support" ON)
option(BUILD_EXT_WEBSOCKETS "Build with internal websockets support" ON)
option(BUILD_EXT_TINYXML2 "Build with internal tinyxml2 support" ON)
option(BUILD_EXT_XXHASH "Build with internal xxhash support" ON)
option(BUILD_EXT_XXTEA "Build with internal xxtea support" ON)
option(BUILD_EXT_CLIPPER "Build with internal clipper support" ON)
option(BUILD_EXT_EDTAA3FUNC "Build with internal edtaa3func support" ON)
option(BUILD_EXT_CONVERTUTF "Build with internal ConvertUTF support" ON)
option(BUILD_EXT_POLY2TRI "Build with internal poly2tri support" ON)
option(BUILD_EXT_MD5 "Build with internal md5 support" ON)
option(BUILD_EXT_CURL "Build with internal curl support" ON)
option(BUILD_EXT_UNZIP "Build with internal unzip support" ON)

add_library(external empty.cpp)

# vcpkg:zlib
find_package(ZLIB REQUIRED)
target_link_libraries(external ZLIB::ZLIB)

# vcpkg:libpng
find_package(libpng CONFIG REQUIRED)
target_link_libraries(external png_static)

# vcpkg:openal-soft
find_package(OpenAL CONFIG REQUIRED)
target_link_libraries(external OpenAL::OpenAL)

# vcpkg:libogg
find_package(Ogg CONFIG REQUIRED)
target_link_libraries(external Ogg::ogg)

# vcpkg libvorbis
find_package(Vorbis CONFIG REQUIRED)
target_link_libraries(external Vorbis::vorbis)
target_link_libraries(external Vorbis::vorbisfile)
target_link_libraries(external Vorbis::vorbisenc)

# FAAD2
add_subdirectory(faad2)
target_link_libraries(external ext_libfaad)

# vcpkg:box2d
if(BUILD_EXT_BOX2D)
    find_package(box2d CONFIG REQUIRED)
    target_link_libraries(external box2d::box2d)
endif(BUILD_EXT_BOX2D)

if(BUILD_EXT_CHIPMUNK)
    set(CP_BUILD_SHARED OFF CACHE BOOL "Build chipmunk as shared library" FORCE)
    set(CP_BUILD_STATIC ON CACHE BOOL "Build chipmunk as static library" FORCE)
    set(CP_BUILD_DEMOS OFF CACHE BOOL "Build chipmunk demos" FORCE)
    set(CP_INSTALL_STATIC OFF CACHE BOOL "Install chipmunk static" FORCE)
    add_subdirectory(chipmunk)
    set_target_properties(chipmunk PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR}/chipmunk/include"
        FOLDER "External"
    )

    # !important adxe not use double precision
    target_compile_definitions(chipmunk PUBLIC CP_USE_CGTYPES=0)
    target_compile_definitions(chipmunk PUBLIC CP_USE_DOUBLES=0)

    #~ include_directories("${CMAKE_CURRENT_SOURCE_DIR}/chipmunk/include")
    target_link_libraries(external chipmunk)
endif(BUILD_EXT_CHIPMUNK)

# vcpkg:freetype
if(BUILD_EXT_FREETYPE2)
    find_package(freetype CONFIG REQUIRED)
    target_link_libraries(external freetype)
endif(BUILD_EXT_FREETYPE2)

if(BUILD_EXT_RECAST)
    add_subdirectory(recast)
    target_link_libraries(external ext_recast)
endif(BUILD_EXT_RECAST)

if(BUILD_EXT_BULLET)
    add_subdirectory(bullet)
    target_link_libraries(external bullet)
endif(BUILD_EXT_BULLET)

# vcpkg:libjpeg-turbo
if(BUILD_EXT_JPEG)
    find_package(JPEG REQUIRED)
    target_link_libraries(external ${JPEG_LIBRARIES})
    target_include_directories(external PUBLIC ${JPEG_INCLUDE_DIR})
endif(BUILD_EXT_JPEG)

# vcpkg:libwebp
if(BUILD_EXT_WEBP)
    find_package(WebP CONFIG REQUIRED)
    target_link_libraries(external WebP::webp WebP::webpdemux WebP::libwebpmux WebP::webpdecoder)
endif(BUILD_EXT_WEBP)

# vcpkg:libwebsockets
if(BUILD_EXT_WEBSOCKETS)
    find_package(libwebsockets CONFIG REQUIRED)
    target_link_libraries(external websockets)
endif(BUILD_EXT_WEBSOCKETS)

if(BUILD_EXT_TINYXML2)
    add_subdirectory(tinyxml2)
    target_link_libraries(external ext_tinyxml2)
endif(BUILD_EXT_TINYXML2)

if(BUILD_EXT_XXHASH)
    add_subdirectory(xxhash)
    target_link_libraries(external ext_xxhash)
endif(BUILD_EXT_XXHASH)

if(BUILD_EXT_XXTEA)
    add_subdirectory(xxtea)
    target_link_libraries(external ext_xxtea)
endif(BUILD_EXT_XXTEA)

if(BUILD_EXT_CLIPPER)
    add_subdirectory(clipper)
    target_link_libraries(external ext_clipper)
endif(BUILD_EXT_CLIPPER)

if(BUILD_EXT_EDTAA3FUNC)
    add_subdirectory(edtaa3func)
    target_link_libraries(external ext_edtaa3func)
endif(BUILD_EXT_EDTAA3FUNC)

if(BUILD_EXT_CONVERTUTF)
    add_subdirectory(ConvertUTF)
    target_link_libraries(external ext_convertUTF)
endif(BUILD_EXT_CONVERTUTF)

if(BUILD_EXT_POLY2TRI)
    add_subdirectory(poly2tri)
    target_link_libraries(external ext_poly2tri)
endif(BUILD_EXT_POLY2TRI)

if(BUILD_EXT_MD5)
    add_subdirectory(md5)
    target_link_libraries(external ext_md5)
endif(BUILD_EXT_MD5)

# vcpkg:curl
if(BUILD_EXT_CURL)
    find_package(CURL CONFIG REQUIRED)
    target_link_libraries(external CURL::libcurl)
endif(BUILD_EXT_CURL)

if(BUILD_EXT_OPENSSL)
    find_package(OpenSSL REQUIRED)
    target_link_libraries(external OpenSSL::SSL OpenSSL::Crypto)
endif(BUILD_EXT_OPENSSL)

# use lua/js specific libs by property to prevent conflict
if(BUILD_LUA_LIBS)
    # add_subdirectory(lua/luajit)
    set(LUA_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/lua/lua54)
    add_subdirectory(lua/lua54)
    add_subdirectory(lua/tolua)
    add_subdirectory(lua/cjson)
    add_subdirectory(lua/lfs)
    add_subdirectory(lua/lpack)
    add_subdirectory(lua/lpeg)
    add_subdirectory(lua/lsproto)
    add_subdirectory(lua/lsqlite3)
    add_subdirectory(lua/luasocket)
    add_subdirectory(lua/lunqlite)
    add_subdirectory(lua/lzlib)
    # add_subdirectory(lua/protobuf)
    add_subdirectory(lua/lua-protobuf)
    set_property(TARGET external APPEND PROPERTY
        CC_LUA_DEPEND ext_lua54 ext_tolua ext_cjson ext_lfs ext_lpack ext_lpeg ext_lsproto ext_lsqlite3 ext_luasocket ext_lunqlite ext_lzlib ext_lua-protobuf
    )
endif()

if(ANDROID)
    add_subdirectory(android-specific/cpufeatures)
    target_link_libraries(external ext_cpufeatures)
endif()

if(WINDOWS)
    # vcpkg:glew
    find_package(GLEW REQUIRED)
    target_link_libraries(external GLEW::GLEW)
endif()

if(WINDOWS OR MACOSX OR LINUX)
    # vcpkg:glfw3
    find_package(glfw3 CONFIG REQUIRED)
    target_link_libraries(external glfw)
endif()

# unzip depend on zlib
if(BUILD_EXT_UNZIP)
    add_subdirectory(unzip)
    target_link_libraries(external ext_unzip)
endif(BUILD_EXT_UNZIP)

# put "external" into External folder, too
set_target_properties(external
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    FOLDER "External"
)

if(MACOSX OR IOS)
    add_subdirectory(glsl-optimizer)
    target_link_libraries(external
    ext_glcpp_library
    ext_glsl_optimizer
    ext_libmesa
    )
endif()
