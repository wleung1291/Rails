class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id

      # t.integer :likeable_id  # a foreign key column 
      # t.string  :likeable_type # a type column
      # This migration can be simplified by using the t.references form:
      t.references :likeable, polymorphic: true, index: true

      t.timestamps
    end
      
    add_index :likes, [:user_id, :likeable_type, :likeable_id], unique: true
  end
end
