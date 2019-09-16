class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ログインしました。"
      redirect_to tasks_path
    else
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
    params.require(:user).permit(:name, :email, :password, :password_confrimation, :admin)
  end
end
