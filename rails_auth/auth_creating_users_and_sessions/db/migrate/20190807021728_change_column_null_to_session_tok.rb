class ChangeColumnNullToSessionTok < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :session_token, :string, null: false

  end
end
