class AddStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :integer, default: 1
  end
end
