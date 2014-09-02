# イベント動画共有システム

## これはなに？

「勉強会などの発表記録を動画で共有できるシステム」を題材にしたrails勉強用サンプルです

## 主な機能（実装サンプル）

* 多対多の取り扱い
* ポリモーフィズムによる関連
* ネストしたリソース
* フォームビルダー
* Ajaxフォーム
* 設定管理
* 位置情報の扱い
* 住所から緯度経度を割り出す
* マップのピンをドラッグして位置情報を編集
* 郵便番号から住所を補完する
* 画像アップロード時のプレビュー
* アクティビティログ
* ユーザー認証 & 権限管理
* ファイルアップロード
* 非同期処理
* websocketによるプッシュ通知
* Amazon SQSでのキュー管理
* 開発に便利なGem


## 動作環境

* ruby 2.1.2
* rails 4.1.4
* MySQL
* Redis
* Amazon Elastic Transcoder
* Amazon Simple Notification Service
* Amazon Simple Queue Service

## 初期設定

### リポジトリのクローン & 必要ライブラリのインストール
```bash
$ git clone git@github.com:k-shogo/rails_recipebook.git
$ bundle install --path vendor/bundle
```

### `config/secret.yml` を作成
`secret.yml`の例

```yaml
development:
  secret_key_base: 0a9cdc75f4735b03060d8f884a7730f4f9c023be5ee698db9d9a2f886899d7b9f10d0f011f9e8421997c46bb057bdaa19a49ed321feee661a3358f2742c39be8

test:
  secret_key_base: d48502694755e2211d87658e7ff5b053e6a4b2a0f2645ebedc405cb1c1ab959fed229b42f554cdc1b195b2345a0d33c98cf16512ede067bfadb6fbb763cd3b87

production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
```

### データベース & テーブルの作成

```bash
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```

### 環境変数

設定サンプルファイルをコピーして必要な値を設定してください。

`cp config/application.yml.sample config/application.yml`

AWSのアクセスキー等を環境変数で与える必要があります。  

```yaml
  aws:
    access_key: 'AXIAJEXMXXWFXCXQEXAX'
    secret:     'wuXhsepuXD6xXPy5X5r1Xr9YXZnsXxE8XgSeXw4X'
    region:     'ap-northeast-1'
    s3_upload_bucket: 'video_bucket'
    transcoder:
      pipeline_id: '1909239909749-x4xtxx'
      presets:
        '1351620000001-000040': 'generic_360p_16_9.mp4'
        '1351620000001-100010': 'iPhone4.mp4'
    sqs_queue_url: 'https://sqs.ap-northeast-1.amazonaws.com/xxxxxxxxx/xxxxxxxxxx'
```


### 管理者アカウントの作成

管理者アカウントはブラウザから追加できないようになっています。  
rails console から直接作成してください。  

```ruby
user = User.create email: 'admin@gmail.com', password: 'testpass'
user.confirm!
```

## 起動方法

### サーバー起動

```
$ bundle exec rails s
```

### アップロードのためのバックグラウンドプロセスの起動

```bash
$ bundle exec sidekiq -q carrierwave -q transcode
```