class User < ApplicationRecord
	before_destroy :must_not_destroy_last_user
	has_many :tasks, dependent: :destroy
	has_secure_password

	def must_not_destroy_last_user
		throw :abort if User.where(admin: true).count == 1
	end

end
