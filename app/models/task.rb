class Task < ApplicationRecord
	validates :name, :description, presence:true
	enum state:{waiting: 0, working: 1, done: 2}
	enum priority:{high: 0, medium: 1, low: 2}
	scope :default, -> { order(created_at: :desc) }
	scope :expired, -> { order(expired_at: :asc) }
	scope :priority, -> { order(priority: :asc) }
end