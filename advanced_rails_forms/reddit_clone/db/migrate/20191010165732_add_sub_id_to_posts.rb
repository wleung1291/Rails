class AddSubIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :sub_id, :integer, null: true
  end
end
