class ApplicationController < ActionController::Base
	include SessionsHelper

	def require_log_in!
		unless logged_in?
			redirect_to login_path, alert:"ログインしてください。"
		end
	end
end
