class ChangeNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :cats, :user_id, false, 0
  end
end
