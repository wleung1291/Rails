class AddSessionTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :session_token, :string, null: true
    add_index :users, :session_token, unique: true
  end
end
