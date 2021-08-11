# アプリケーションの概要
作った料理を記録して共有できる、料理投稿SNSサービス。 <アプリケーションのURL>

# 技術的ポイント
・**RSpec**でModel, Request, Systemテスト記述（計219examples）  
・**Ajax**を用いた非同期処理（フォロー/未フォロー、お気に入り登録/未登録などの切り替え表示）  
・**Bootstrap**によるレスポンシブ対応  
・**Rubocop**を使用したコード規約に沿った開発  
・**9つのモデル**をそれぞれ関連付けて使用  

# アプリケーションの機能
・作った料理を投稿  
・画像を正方形に整形して投稿（CarrierWaveを使用）  
・料理ログ登録（料理を作る度にログを追加し、これまでにいつ作ったか、何回作ったかが一目でわかる）  
・別ユーザーの料理に対して「食べたい！」リクエストを送信  
・フォロー  
・お気に入り登録  
・コメント  
・通知（お気に入り登録 or コメントがあった場合）  
・検索（Ransackを使用）  
・CSV出力  
・ログイン  
・ログイン状態の保持  
・モデルに対するバリデーション  

# 環境
■フレームワーク  
　Ruby on Rails  
■データベース  
　PostgreSQL  



# users table

|  attribute|type |
| -------- | ----------- |
| name     | string  |
| email    | string  |
| picture| string  |
|introduction | text   |
| sex   |strings  | 
| admin|  boolean|
|password_digest|  | 
|remember_digest|  |   


### Association
has_many :dishes, dependent: :destroy

has_many :active_relationships, class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy

has_many :following, through: :active_relationships, source: :followed

has_many :passive_relationships, class_name: "Relationship",foreign_key: "followed_id", dependent: :destroy

has_many :favorites, dependent: :destroy

has_many :notifications, dependent: :destroy

has_many :lists, dependent: :destroy

has_many :followers, through: :passive_relationships, source: :follower

has_many :favorites, dependent: :destroy


# relationship table

| attribute| type     |
| -------- | ----------- |
 |follower_id  |integer| 
 |followed_id  |ingefer| 

### Association
belongs_to :follower, class_name: "User"

belongs_to :followed, class_name: "User" 



# dish table
| attribute| type     |
| -------- | ----------- |
|name|string|
|user_id| integer |
|picture| string |
|description| text |
|portion| float |
|tips|  text|
|reference| text |
|required_time|integer|
|popularity|integer|
|cook_memo|text|

### Association
belongs_to :user

has_many :favorites, dependent: :destroy

has_many :comments, dependent: :destroy

has_many :lists, dependent:  :destroy

has_many :logs, dependent: :destroy

has_many :ingredients, dependent: :destroy 

# ingredent table
| attribute| type     |
| -------- | ----------- |
|name|string|
|dish_id|integer|
|quantity|string|
### Association
belongs_to :dish

# favorite table
| attribute| type     |
| -------- | ----------- |
|user_id|integer|
|dish_id|integer|
### Association
belongs_to :user

belongs_to :dish
# comment table
|attribute| type     |
| -------- | ----------- |
|dish_id|integer|
|user_id|integer|
|content|text|
### Association
belongs_to :dish

# notifacation table
|attribute| type     |
| -------- | ----------- |
|dish_id|integer|
|user_id|integer|
|variety|integer|
|content|text|
|from_user_id|integer|
### Association
belongs_to :user

# list table
|attribute| type     |
| -------- | ----------- |
|dish_id|integer|
|user_id|integer|
|from_user_id|integer|
### Association
belongs_to :user

belongs_to :dish


# log table
|attribute| type     |
| -------- | ----------- |
|dish_id|integer|
|content|text|
### Association
belongs_to :dish


