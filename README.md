# Ark-advent-2016の実施

### 目的
Arkのコンテナ実行環境と構築し、Arkフレームワークを理解する。

### 方法

こちらを実施する。
http://konboi.github.io/ark-advent-2016/01

### 手順書

#### 1. Docker for Macをインストール
https://docs.docker.com/docker-for-mac/install/

#### 2. プロジェクトソースをクローン
```
$ eval `ssh-agent`
$ ssh-add [SSH秘密鍵]
$ git clone git@github.com:goroutine/ark.git

```
#### 3. MySQLコンテナを初期化
```
$ cd docker/local
$ docker-compose down
$ rm -rf mysql/data/*
```

#### 4. MySQLコンテナを起動
```
$ docker-compose up -d
``` 

#### 5. Appコンテナをビルド
```
$ cd docker/local/app
$ make build
```

#### 6. Appコンテナで作業
```
$ make bash
（コンテナ内に移動する）
```

#### 7. deploy.pmでSchemaからテーブルを作成
```
(コンテナ内で実行)
$ cd Jobeet
$ carton exec perl deploy.pl
```

#### 8. MySQL Clientで確認
```
(コンテナ内で実行)
$ ip route
default via 172.17.0.1 dev eth0
172.17.0.0/16 dev eth0  proto kernel  scope link  src 172.17.0.3

$ mysql -h 172.17.0.1 -uroot -p
```

#### 9. plackupでサーバー起動
```
(コンテナ内で実行)
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
#### 10. ブラウザからアクセス
ホストPCのブラウザから http://0.0.0.0:5000/ にアクセス

#### 11. コンテナから抜ける
```
(コンテナ内で実行)
ctrl + c でサーバーを停止してから
$ exit
```
