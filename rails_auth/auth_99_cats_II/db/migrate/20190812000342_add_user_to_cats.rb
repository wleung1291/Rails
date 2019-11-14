class AddUserToCats < ActiveRecord::Migration[5.2]
  def change
    add_column :cats, :user_id, :integer, null: true
    add_index :cats, :user_id
  end
end
