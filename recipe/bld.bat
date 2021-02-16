cmake -S%SRC_DIR% ^
      -Bbuild ^
      -GNinja ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%;%LIBRARY_LIB% ^
      -DLTDL_INCLUDE_DIR=%SRC_DIR%\ltdl_compat
if errorlevel 1 exit 1

cmake --build build -- install
if errorlevel 1 exit 1
