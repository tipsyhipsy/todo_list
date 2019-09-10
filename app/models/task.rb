class Task < ApplicationRecord
	validates :name, :description, presence:true
	enum state:{waiting: 0, working: 1, done: 2}
	scope :default, -> { order(created_at: :desc) }
	scope :expired, -> { order(expired_at: :asc) }
end
