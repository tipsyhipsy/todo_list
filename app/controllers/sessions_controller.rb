class SessionsController < ApplicationController
	layout 'logout'
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in user
			redirect_to root_path(user.id), notice:"ログインしました。"
		else
			flash[:danger] = "ログインに失敗しました。"
			render :new
		end
	end

	def destroy
		session.delete(:user_id)
		redirect_to login_path, notice: "ログアウトしました。"
	end
end

