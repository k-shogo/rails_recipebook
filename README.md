# 動画入稿システム

## 主な機能

* 動画のアップロード
    * アップロード先はAmazon S3 にすることが出来ます
    * Amazon Elastic Transcoder を利用してアップロードした動画を自動的に変換することができます

## 動作環境

* ruby 2.1.2
* rails 4.1.4
* MySQL
* Redis
* Amazon Elastic Transcoder

## 初期設定

### リポジトリのクローン & 必要ライブラリのインストール
```bash
$ git clone ssh://git@stash.rmp-oudan.net:7999/rted/rted-server-twin.git
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

AWSのアクセスキー等を環境変数で与える必要があります。  
`.env`ファイルでの記述例

```
AWS_ACCESS_KEY=AXIAJEXMXXWFXCXQEXAX
AWS_SECRET=wuXhsepuXD6xXPy5X5r1Xr9YXZnsXxE8XgSeXw4X
AWS_REGION=ap-northeast-1
S3_UPLOAD_BUCKET=stoat
TRANSCODER_PIPELINE_ID=1909239909749-x4xtxx
```

### 管理者アカウントの作成

管理者アカウントはブラウザから追加できないようになっています。  
rails console から直接作成してください。  
password と password_confirmation (パスワードの確認）は同じものである必要があります。

```ruby
user = User.create email: 'admin@gmail.com', password: 'testpass', password_confirmation: 'testpass', role: 'admin'
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