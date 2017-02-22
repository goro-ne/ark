# Ark-advent-2016 - Day01

## 目的
Ark実行環境、Arkフレームワークを理解する。

## 方法

こちらを実施します。
http://konboi.github.io/ark-advent-2016/01

## 環境構築

- Docker for Macをインストール
https://docs.docker.com/docker-for-mac/install/
- プロジェクトソースをクローン
```
$ eval `ssh-agent`
$ ssh-add [SSH秘密鍵]
$ git clone git@github.com:goroutine/ark.git
```
- MySQLコンテナを初期化
```
$ cd docker/local
$ docker-compose down
$ rm -rf mysql/data/*
```
- MySQLコンテナを起動
```
$ docker-compose up -d
``` 
- Appコンテナをビルド
```
$ cd docker/local/app
$ make build
```
- Appコンテナを起動
```
$ make bash
```
- テーブル作成
```
$ cd Jobeet
$ carton exec perl deploy.pl
```
- サーバー起動
```
$ cd Jobeet
$ plackup -r dev.psgi

Watching ./lib dev.psgi for file updates.
[debug] Loaded Path actions:
.--------------------------------------+---------------------------------------.
| Path                                 | Private                               |
+--------------------------------------+---------------------------------------+
| /                                    | /index                                |
| /...                                 | /default                              |
'--------------------------------------+---------------------------------------'


[debug] Setup finished
HTTP::Server::PSGI: Accepting connections at http://0:5000/
```
- ブラウザからアクセス
ホストPCのブラウザから http://0.0.0.0:5000/ にアクセス

