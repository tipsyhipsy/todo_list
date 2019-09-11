class ChangeExpiredAtDatetimeToDateFromTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :expired_at, :datetime
  end
end
