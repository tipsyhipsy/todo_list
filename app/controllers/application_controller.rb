class ApplicationController < ActionController::Base
	include SessionsHelper

	def require_log_in!
		unless logged_in?
			flash[:alert] = "ログインしてください。"
			redirect_to new_session_path
		end
	end
end
