class Task < ApplicationRecord
	default_scope -> { order(created_at: :desc) }
	validates :name, :description, presence:true
end
