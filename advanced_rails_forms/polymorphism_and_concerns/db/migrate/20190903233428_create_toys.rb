class CreateToys < ActiveRecord::Migration[5.2]
  def change
    create_table :toys do |t|
      t.string :name, null: false
      t.references :toyable, polymorphic: true, index: true

      t.timestamps
    end

    # want to ensure that all toys are unique by their name, toyable_id, and 
    # toyable_type properties. If one cat has a toy with a name of "ball", then 
    # another cat should also be able to have a toy with a name of "ball". 
    # However, one cat should not be able to have multiple toys by the name of 
    # "ball".
    add_index :toys, [:name, :toyable_id, :toyable_type], unique: true
  end
end
