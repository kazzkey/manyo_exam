# Manyo_exam

##　Requirement
* Ruby 2.6.5
* Rails 5.2.4

## Deploy

`$ heroku login`
`$ heroku create`
コミットされているかを確認の上、
`$ git push heroku master`
`$ heroku run rails db:migrate`


## usersテーブル

|Colomn|Type|Options|
|------|------|------|
|user|string| |
|email|string| |
|password_digest|string| |

### Association
- has_many :tasks
- has_many :labels

## tasksテーブル

|Colomn|Type|Options|
|------|------|------|
|name|string|null: false|
|content|text|null: false|
|deadline|date| |
|status|string| |
|priority|string| |
|user|references|foreign_key: true|

### Association
- belongs_to :user
- has_many :tasks_labels
- has_many :labels, through: :tasks_labels


## labelsテーブル

|Colomn|Type|Options|
|------|------|------|
|name|string| |

### Association
- belongs_to :user
- has_many :tasks_labels
- has_many :tasks, through: :tasks_labels


## tasks_labelsテーブル
|Colomn|Type|Options|
|------|------|------|
|tasks|references|foreign_key: true|
|labels|references|foreign_key: true|

### Association
- belongs_to :task
- belongs_to :label
