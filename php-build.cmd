@echo off
cd "%~dp0"

set /p phpversion="PHPのバージョンを入力してください。(7.4.16/8.0.3 etc...) : "
set /p oraver="instantclientのバージョンを入力してください（12_2 or 19_10, 18_5 etc...）：　"
set /p etcmod="その他のconfigureオプション(--with-sqlite3等)：　"

if %phpversion:~0,1% == 7 (
	set vernum=2017
	set verstr=vc15
) else (
	set vernum=2019
	set verstr=vs16
)
set dpver=%phpversion:~0,3%

echo PHP-%phpversion%を%verstr%でビルドします。
echo;

call "C:\Program Files (x86)\Microsoft Visual Studio\%vernum%\Community\VC\Auxiliary\Build\vcvars64.bat"

if NOT EXIST php-sdk\*.* (
	git clone -b master https://github.com/microsoft/php-sdk-binary-tools.git php-sdk
)
cd php-sdk
git pull

@call phpsdk-%verstr%-x64.bat
