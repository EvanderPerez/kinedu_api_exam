class AddUserForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :user

    add_column :tasks, :created_by_id, :integer
    add_column :tasks, :assigned_to_id, :integer

    add_foreign_key :tasks, :users, column: :created_by_id, primary_key: :id
    add_foreign_key :tasks, :users, column: :assigned_to_id, primary_key: :id
  end
end
