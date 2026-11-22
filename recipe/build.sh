#!/bin/bash
set -ex

declare -a _xtra_cmake_args
if [[ "${target_platform}" == osx-* ]]; then
    _xtra_cmake_args+=(
        -DWITH_QUARTZ=ON
        # the plugins are installed as @rpath/libgvplugin_*.dylib in lib/graphviz, and gvpack
        # links one of them directly
        "-DCMAKE_INSTALL_RPATH=@loader_path;@loader_path/../lib/graphviz"
    )
else
    _xtra_cmake_args+=(
        -DWITH_QUARTZ=OFF
        # gvpack links a plugin (lib/graphviz) directly
        "-DCMAKE_INSTALL_RPATH=\$ORIGIN/../lib/graphviz"
    )
fi

cmake -S . -B build -G Ninja \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DBUILD_SHARED_LIBS=ON \
    -DENABLE_LTDL=ON \
    -DWITH_EXPAT=ON \
    -DWITH_ZLIB=ON \
    -DWITH_GDK=ON \
    -DWITH_RSVG=ON \
    -DWITH_WEBP=ON \
    -DWITH_X=OFF \
    -DWITH_GTK=OFF \
    -DWITH_GVEDIT=OFF \
    -DWITH_SMYRNA=OFF \
    -DWITH_POPPLER=OFF \
    -DWITH_GHOSTSCRIPT=OFF \
    -DENABLE_TCL=OFF \
    -DENABLE_SWIG=OFF \
    -DENABLE_SHARP=OFF \
    -DENABLE_D=OFF \
    -DENABLE_GO=OFF \
    -DENABLE_GUILE=OFF \
    -DENABLE_JAVA=OFF \
    -DENABLE_JAVASCRIPT=OFF \
    -DENABLE_LUA=OFF \
    -DENABLE_PERL=OFF \
    -DENABLE_PHP=OFF \
    -DENABLE_PYTHON=OFF \
    -DENABLE_R=OFF \
    -DENABLE_RUBY=OFF \
    "${_xtra_cmake_args[@]}"

cmake --build build --parallel "${CPU_COUNT}"
cmake --install build

# Register the plugins (lib/graphviz/config8). This runs the freshly built dot, so it needs a
# native build; cross-compiled builds (linux-ppc64le) register them at install time instead.
if [[ "${build_platform}" == "${target_platform}" ]]; then
    "${PREFIX}/bin/dot" -c
else
    install -m 755 "${RECIPE_DIR}/post-link.sh" "${PREFIX}/bin/.graphviz-post-link.sh"
fi
