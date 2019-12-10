### php_imagick.dllをWindows10-64bitでビルドするためのもの 

毎回コマンド忘れるので、コマンドをバッチに纏めただけです  
phpのビルド環境が揃っている前提だし、誰でもビルド出来るようにするものじゃないです  
VisualStudio2017 or 2019とGit for Windowsが必要です  
instantclient_11_2のディレクトリがスクリプトと同じ階層にあるとociもビルドします  
エラーチェックなどは一切していないので、エラーが出た際は自身で直してください  
スクリプトでphp_imagickのバージョンをISTweak built it.に変更してます  

##### ImageMagickのビルド（masterブランチを取得します）

ImageMagick.cmdを実行  
ImageMagick\ImageMagick-Windows\VisualMagick\configure\configure.vcxprojをVS2017で開く  
そのまま実行してウィザードを進める（最初の64bitにチェック、VS2017,VS2019を選択）  
ImageMagick\ImageMagick-Windows\VisualMagick\VisualDynamicMT.slnを開いてReleaseでソリューションのビルド  
ImageMagick-2.cmdを実行  

##### phpのビルド

php-build.cmdを実行  
phpのバージョン(7.2.24とか7.3.11)とVisualStudioのバージョン（15 or 16）を入力  
開かれたコマンドプロンプトでphp-build-1.cmdを実行  

https://github.com/ImageMagick/  
https://github.com/mkoppanen/imagick.git  
https://github.com/microsoft/php-sdk-binary-tools.git  
https://github.com/php/php-src.git  