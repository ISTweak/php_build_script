@echo off
cd "%~dp0"

set /p phpversion="PHP�̃o�[�W��������͂��Ă��������B(7.2.25) : "
set /p vsver="VisualStudio�̃o�[�W��������͂��Ă��������i15 or 16�j�F�@"
set /p dpver="phpsdk_deps�̃u�����`����͂��Ă��������imaster or 7.4�j�F�@"
set /p etcmod="���̑���configure�I�v�V�����F�@"
echo PHP-%phpversion%��VC%vsver%�Ńr���h���܂��B
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
