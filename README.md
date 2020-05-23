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
|name|string| |
|content|text| |
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
