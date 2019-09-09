class Task < ApplicationRecord
	validates :name, :description, presence:true
	enum state:{waiting: 0, working: 1, done: 2}
end
