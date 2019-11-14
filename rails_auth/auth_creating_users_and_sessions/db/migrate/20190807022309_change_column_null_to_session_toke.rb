class ChangeColumnNullToSessionToke < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :session_token, :string, :default => 0, :null => false
  end
end
