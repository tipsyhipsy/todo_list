class RemoveIndexFromDescription < ActiveRecord::Migration[5.2]
  def change
    remove_index :tasks, :description
  end
end
