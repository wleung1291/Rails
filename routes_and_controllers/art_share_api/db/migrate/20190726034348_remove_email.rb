class RemoveEmail < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :email, :string
  end
end
