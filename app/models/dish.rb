class Dish < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy  
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

  private

def picture_size
  if picture.size > 5.megabytes
    errors.add(:picture, "：5MBより大きい画像はアップロードできません。")
  end
end
end
