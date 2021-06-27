@echo off

call phpsdk_buildtree.bat phpmaster

rd /s /q pecl\imagick
git clone -b master https://github.com/mkoppanen/imagick.git pecl\imagick
sed -i -e 's/@PACKAGE_VERSION@/ISTweak built it./' pecl\imagick\php_imagick.h

if NOT EXIST php-%phpversion% (
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
if EXIST ..\..\..\..\..\instantclient_%oraver%\sdk (
	xcopy ..\..\..\..\..\instantclient_%oraver%\sdk\lib\msvc\*.lib ..\deps\lib /Y
	xcopy ..\..\..\..\..\instantclient_%oraver%\sdk\include\*.h ..\deps\include /Y
	if %phpversion:~0,1% == 8 (
		if %oraver:~0,2% == 19 (
			set OCI=--enable-pdo --with-pdo-oci=shared --with-oci8-19=shared --with-pdo-oci=shared
		) else (
			set OCI=--enable-pdo --with-pdo-oci=shared --with-oci8-12c=shared --with-pdo-oci=shared
		)
	) else (
		set OCI=--with-oci8-12c=shared --with-pdo-oci=shared
	)
)

if EXIST Makefile (
	nmake clean
)
call buildconf --force
if "%etcmod%" equ "snap" (
	call configure --enable-snapshot-build --enable-com-dotnet=shared --without-analyzer %OCI%
	call nmake
	nmake snap
) else (
	call configure --disable-all --enable-cli --with-all-shared --with-imagick --with-sqlite3 %OCI% %etcmod%
	call nmake
	xcopy x64\Release_TS\php_*.dll ..\..\..\..\..\ /Y
)
cd ..\..\..\..\..\