@ -1,24 +1,79 @@
# README

This README would normally document whatever steps are necessary to get the
application up and running.
# README

#users table

| Column            | Type    | Options     |
| --------          | ------  | ----------- |
| name          | string  |null: false  |
| email             | string  |null: false ,unique: true|
| picture| string  |  | 
|introduction            | text   |  | 
| sex   |strings  |         |
| admin|  boolean|      | 
|password_digest|  |        | 
|remember_digest|  |        | 


### Association
has_many :prototypes,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :prototype_likes, through: :likes, source: :prototype


#relationship table
|           |  || 
|           |  || 

### Association
belongs_to :country
belongs_to :user
has_many :comments,dependent: :destroy
has_one_attached :image
has_many :likes,dependent: :destroy
has_many :users, through: :likes



#dish table
|           |  || 
|           |  || 
|           |  || 
|           |  || 
|           |  || 
|           |  || 
|           |  || 
|           |  || 

Things you may want to cover:
### Association
belongs_to :prototype
belongs_to :user

* Ruby version

* System dependencies

* Configuration
＃likes table
| Column         | Type      | Options     |
| --------       | ------    | ----------- |
|prototype_id      | reference    |foreign key |
|user_id           |reference   |foreign key |
### Association
belongs_to :user
belongs_to :prototype

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)
 ## アプリの名前
 -trippin'asia(URL:https://trippinasia.herokuapp.com/)

* Deployment instructions
## 使用ライブラリ、フレーム

* ...
-html&css
-JavaScript
-jQuery
-Ruby
-Ruby on Rails
-MySqL
-AWS
