@echo off
cd "%~dp0"

set /p phpversion="PHPのバージョンを入力してください。(7.2.25) : "
set /p vsver="VisualStudioのバージョンを入力してください（15 or 16）：　"
set /p dpver="phpsdk_depsのブランチを入力してください（master or 7.4）：　"
set /p etcmod="その他のconfigureオプション：　"
echo PHP-%phpversion%をVC%vsver%でビルドします。
echo;

if %vsver%==15 (
	set vernum=2017
	set verstr=vc15
) else (
	set vernum=2019
	set verstr=vs16
)
call "C:\Program Files (x86)\Microsoft Visual Studio\%vernum%\Community\VC\Auxiliary\Build\vcvars64.bat"

if NOT EXIST php-sdk\*.* (
	git clone -b master https://github.com/microsoft/php-sdk-binary-tools.git php-sdk
)
cd php-sdk
git pull

@call phpsdk-%verstr%-x64.bat
