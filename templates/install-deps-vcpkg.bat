@echo off

IF not EXIST %VCPKG_ROOT% (
    echo env 'VCPKG_ROOT' is not set, please make sure it is set to vcpkg installed path
    pause
    exit -1
})

%VCPKG_ROOT%\vcpkg install zlib:x64-windows-static libjpeg-turbo:x64-windows-static freetype:x64-windows-static openssl:x64-windows-static libwebp:x64-windows-static libwebsockets:x64-windows-static curl:x64-windows-static openal-soft:x64-windows-static libogg:x64-windows-static libvorbis:x64-windows-static glew:x64-windows-static glfw3:x64-windows-static  box2d:x64-windows-static

pause
