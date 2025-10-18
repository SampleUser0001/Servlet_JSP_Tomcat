# Tomcat + log4jのログ出力動作確認

## 概要

Tomcat + log4j2の場合、通常log4j2.xmlは`アプリケーションホーム/WEB-INF/classes/log4j2.xml`に配置されるが、
Tomcatの起動時にclasspathを追加で指定し、`log4j2.xml`ファイルをそのディレクトリ配下に配置した場合でも、`log4j2.xml`を読み込んでログが出力されるか確認したい。

## その他

TomcatはDocker上で動作する。Dockerの設定については`docker`ディレクトリ配下に作成すること。