class ChangeUseridType < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :user_id, :integer, using: 'user_id::integer'
  end
end
