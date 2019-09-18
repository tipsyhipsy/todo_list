class Admin::UsersController < ApplicationController
	# before_action :admin_user
	before_action :set_user, only: %i[show edit destroy]

	def index
		@users = User.select(:id, :name, :email, :admin, :created_at)
	end

	def new
		@user = User.new
	end

	def create
		@user = User(user_params)
		if @user.save
			redirect_to admin_users_path, notice:"作成しました。"
		else
			render :new, alert:"作成に失敗しました。"
		end
	end

	def show
		@tasks = Task.where(user_id: @user.id)
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to admin_user_path(@user)
		else
			render :edit, alert:"更新に失敗しました。"
		end
	end

	def destroy
	end

	private

	# def admin_user
	# 	redirect_to(root_path) unless current_user.admin?
	# end

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
	end

	def set_user
		@user = User.find(params[:id])
	end
end
