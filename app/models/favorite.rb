class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :dish
    default_scope -> { order(created_at: :desc) } # 追記

    validates :user_id, presence: true  # 追記
    validates :dish_id, presence: true  # 追記
end
