cd "%~dp0"

rd /s /q ImageMagick\include
rd /s /q ImageMagick\lib
rd /s /q ImageMagick\dll

md ImageMagick\include
md ImageMagick\include\Magick++
md ImageMagick\include\MagickCore
md ImageMagick\include\MagickWand
md ImageMagick\lib
md ImageMagick\dll

xcopy ImageMagick\ImageMagick-Windows\ImageMagick\Magick++\lib\Magick++ ImageMagick\include\Magick++
xcopy ImageMagick\ImageMagick-Windows\ImageMagick\MagickCore\*.h ImageMagick\include\MagickCore
xcopy ImageMagick\ImageMagick-Windows\ImageMagick\MagickWand\*.h ImageMagick\include\MagickWand
xcopy ImageMagick\ImageMagick-Windows\ImageMagick\Magick++\lib\Magick++.h ImageMagick\include
xcopy ImageMagick\ImageMagick-Windows\VisualMagick\lib\CORE_RL_Magick++_.lib ImageMagick\lib
xcopy ImageMagick\ImageMagick-Windows\VisualMagick\lib\CORE_RL_MagickCore_.lib ImageMagick\lib
xcopy ImageMagick\ImageMagick-Windows\VisualMagick\lib\CORE_RL_MagickWand_.lib ImageMagick\lib
xcopy ImageMagick\ImageMagick-Windows\VisualMagick\bin\CORE_RL_*.dll ImageMagick\dll
