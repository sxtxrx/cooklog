class Dish < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :lists, dependent:  :destroy
  has_many :logs, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 140 }
  validates :tips, length: { maximum: 50 }
  validate  :picture_size
  validates :popularity,
            :numericality => {
              :only_integer => true, # スペルチェック
              :greater_than_or_equal_to => 1,
              :less_than_or_equal_to => 5
            },
            allow_nil: true
            mount_uploader :picture, PictureUploader

            def feed_comment(dish_id)
              Comment.where("dish_id = ?", dish_id)
            end

  # 料理に付属するログのフィードを作成
  def feed_log(dish_id)
    Log.where("dish_id = ?", dish_id)
  end

def picture_size
  if picture.size > 5.megabytes
    errors.add(:picture, "：5MBより大きい画像はアップロードできません。")
  end
end
end
