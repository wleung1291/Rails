class ChangeColumnNullToSessionTo < ActiveRecord::Migration[5.2]
  def change    
    change_column_null :users, :session_token, :null => false

  end
end
