@echo off

call phpsdk_buildtree.bat phpmaster

rd /s /q pecl\imagick
git clone -b master https://github.com/mkoppanen/imagick.git pecl\imagick
sed -i -e 's/@PACKAGE_VERSION@/ISTweak built it./' pecl\imagick\php_imagick.h

if NOT EXIST php-%phpversion%\*.* (
	git clone -b PHP-%phpversion% https://github.com/php/php-src.git php-%phpversion%
)
cd php-%phpversion%

call phpsdk_deps --update --branch %dpver%

xcopy ..\..\..\..\..\ImageMagick\lib\*.lib ..\deps\lib /Y
xcopy ..\..\..\..\..\ImageMagick\include ..\deps\include /Y
xcopy ..\..\..\..\..\ImageMagick\include\Magick++ ..\deps\include\Magick++ /I /Y
xcopy ..\..\..\..\..\ImageMagick\include\MagickCore ..\deps\include\MagickCore /I /Y
xcopy ..\..\..\..\..\ImageMagick\include\MagickWand ..\deps\include\MagickWand /I /Y

set OCI=""
if EXIST ..\..\..\..\..\instantclient_11_2\*.* (
	xcopy ..\..\..\..\..\instantclient_11_2\sdk\lib\msvc\*.lib ..\deps\lib /Y
	xcopy ..\..\..\..\..\instantclient_11_2\sdk\include\*.h ..\deps\include /Y
	set OCI="--with-oci8"
)

call buildconf
call configure --disable-all --enable-cli --with-all-shared --with-imagick %OCI% %etcmod%
call nmake

xcopy x64\Release_TS\php_*.dll ..\..\..\..\..\ /Y
call nmake clean

cd ..\..\..\..\..\

if EXIST php_imagick.dll (
	ren php_imagick.dll php_imagick-%phpversion%-%verstr%-x64.dll
)
if EXIST php_oci8.dll (
	ren php_oci8.dll php_oci8-%phpversion%-%verstr%-x64.dll
)
cd php-sdk