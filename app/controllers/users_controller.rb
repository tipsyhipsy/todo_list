class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  before_action :ensure_correct_user, only: %i[show edit update]

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
      render layout: 'logout'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_path, success: "ログインしました。"
    else
      flash[:danger] = "登録に失敗しました。"
      render :new, layout: 'logout'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
			redirect_to admin_users_path(@user)
		else
			render :edit, alert:"更新に失敗しました。"
		end
  end

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def ensure_correct_user
    if current_user.id !=  @user.id
      redirect_to root_path, alert: "権限がありません。"
    end
  end
end
