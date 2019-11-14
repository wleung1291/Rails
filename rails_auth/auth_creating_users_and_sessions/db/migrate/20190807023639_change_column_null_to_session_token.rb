class ChangeColumnNullToSessionToken < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :session_token, :default => 0, :null => false
  end
end
