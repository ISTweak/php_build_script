cd "%~dp0"

md ImageMagick
cd ImageMagick

if NOT EXIST ImageMagick-Windows\*.* (
	git clone -b main --depth 1 https://github.com/ImageMagick/ImageMagick-Windows.git ImageMagick-Windows
)
cd ImageMagick-Windows
git pull

call .\CloneRepositories.cmd
