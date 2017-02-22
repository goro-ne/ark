# Ark-advent-2016

## 目的
Ark実行環境、Arkフレームワークを理解する。

## 方法

こちらを実施します。
http://konboi.github.io/ark-advent-2016/01

## 手順書

- 1. Docker for Macをインストール
https://docs.docker.com/docker-for-mac/install/
- 2. プロジェクトソースをクローン
```
$ eval `ssh-agent`
$ ssh-add [SSH秘密鍵]
$ git clone git@github.com:goroutine/ark.git
```
- 3. MySQLコンテナを初期化
```
$ cd docker/local
$ docker-compose down
$ rm -rf mysql/data/*
```
- 4. MySQLコンテナを起動
```
$ docker-compose up -d
``` 
- 5. Appコンテナをビルド
```
$ cd docker/local/app
$ make build
```
- 6. Appコンテナを起動
```
$ make bash
```
- 7. deploy.pmでSchemaからテーブルを作成
```
$ cd Jobeet
$ carton exec perl deploy.pl
```
- 8. plackupでサーバー起動
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
- 9. ブラウザからアクセス
ホストPCのブラウザから http://0.0.0.0:5000/ にアクセス

