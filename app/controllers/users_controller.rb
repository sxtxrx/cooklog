class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:show,:edit, :update]
  before_action :correct_user, only: [:edit,:update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page])
  end 

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "クックログへようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_update)
      flash[:success] = "プロフィールが更新されました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
  def user_params_update
    params.require(:user).permit(:name,:email, :introduction, :sex)
  end
  def correct_user
    @user = User.find(params[:id])
    if !current_user?(@user)
      flash[:danger] = "このページにはアクセスできません"
      redirect_to(root_url)
    end
  end


end
