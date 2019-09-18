class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  before_action :ensure_correct_user, only: %i[show edit update]

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_path, success: "ログインしました。"
    else
      flash[:danger] = "登録に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
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
      redirect_to root_path, notice: "権限がありません。"
    end
  end
end
