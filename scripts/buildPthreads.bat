cls
@echo on

:: Setup visual Studio Environment
pushd \
:: change to c: Drive
cd /D C:
:: run command line tool in VS 2017
set dirEnterprise=C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\
set dirProfessional=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\
set dirCommunity=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\

if exist "%dirEnterprise%" cd "%dirEnterprise%"
if exist "%dirProfessional%" cd "%dirProfessional%"
if exist "%dirCommunity%" cd "%dirCommunity%"

:: compiling in x64 mode
:: from https://stackoverflow.com/a/19929778
if not defined DevEnvDir (
	call vcvars64.bat
)
popd


:: Build TGA-Loader and dependencies
cd ..

:: remove any previous build dir
rmdir /s /q build
rmdir /s /q install

:: create build dir
mkdir build

:: create install dir
mkdir install

:: move inside build dir
cd build

:: generate project files
Set CMAKE_GEN= -G "Visual Studio 15 2017 Win64"
Set CMAKE_CONFIGURATION_TYPE= -DCMAKE_CONFIGURATION_TYPES=Release;Debug
cmake %CMAKE_GEN% %CMAKE_CONFIGURATION_TYPE% ..

:: build projects
msbuild "pthreads-x64.sln" /t:Rebuild /p:Configuration=Release
set BUILD_STATUS=%ERRORLEVEL%
if %BUILD_STATUS%==0 echo Build success
if not %BUILD_STATUS%==0  goto enderror

msbuild "pthreads-x64.sln" /t:Rebuild /p:Configuration=Debug
set BUILD_STATUS=%ERRORLEVEL%
if %BUILD_STATUS%==0 echo Build success
if not %BUILD_STATUS%==0  goto enderror

:endok
cd ..
cd scripts
exit /b

:enderror
cd ..
cd scripts
exit /b %BUILD_STATUS%

