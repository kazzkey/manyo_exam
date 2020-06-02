# README(Manyo_exam)

## Description
* タスク管理アプリです。

## Requirement
* Ruby 2.6.5
* Rails 5.2.4
* Postgresql 12.2

## HowToDeploy
```
$ heroku login
$ heroku create
```

コミットを確認の上、
```
$ git push heroku master
$ heroku run rails db:migrate
```

## Model

### usersテーブル
|Colomn|Type|Options|
|-----|-----|-----|
|user|string|null: false|
|email|string|null: false, unique: true|
|password_digest|string|null: false|
|admin|boolean|default: false, null: false|

#### Association
- has_many :tasks, dependent: :destroy

### tasksテーブル
|Colomn|Type|Options|
|-----|-----|-----|
|name|string|null: false|
|content|text|null: false|
|expired_at|date|default: "2020-01-01", null: false|
|status|string|default: "未着手", null: false|
|priority|integer|default: 0, null: false|
|user|references|foreign_key: true|

#### Association
- belongs_to :user
- has_many :labellings, dependent: :destroy
- has_many :labels, through: :labellings


### labelsテーブル

|Colomn|Type|Options|
|-----|-----|-----|
|name|string| |

#### Association
- belongs_to :user
- has_many :labellings, dependent: :destroy
- has_many :tasks, through: :labellings


### labellingsテーブル
|Colomn|Type|Options|
|-----|-----|-----|
|tasks|references|foreign_key: true|
|labels|references|foreign_key: true|

#### Association
- belongs_to :task
- belongs_to :label
