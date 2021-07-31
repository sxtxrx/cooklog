class NotificationsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :create

  def index
    # current_userに対する通知の集合を取得
    @notifications = current_user.notifications
    # 一度indexページを開いたら、ユーザーの「通知フラグ」を削除
    current_user.update_attribute(:notification, false)
  end

  def correct_user
    dish = current_user.dishes.find_by(id: [:dish_id])
    redirect_to root_url if dish.nil?
  end
end
