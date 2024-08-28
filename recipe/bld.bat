@echo on

mkdir build
cd build

:: Primary build
cmake -G Ninja ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=ON ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%;%LIBRARY_LIB% ^
      -DLTDL_INCLUDE_DIR=%SRC_DIR%\ltdl_compat ^
      -Dwith_gvedit=OFF ^
      -Denable_tcl=OFF ^
      -Duse_win_pre_inst_libs=OFF ^
      -Dinstall_win_dependency_dlls=OFF ^
      ..
if %ERRORLEVEL% neq 0 exit 1

cmake --build .
if %ERRORLEVEL% neq 0 exit 1

cmake --install .
if %ERRORLEVEL% neq 0 exit 1
