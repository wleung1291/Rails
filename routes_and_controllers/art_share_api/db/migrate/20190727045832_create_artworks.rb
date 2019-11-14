class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.integer :artist_id, null: false

      t.timestamps
    end

    add_index :artworks, :artist_id
    add_index :artworks, :image_url, unique: true
    
    # Perform a fast query on title or title AND artist_id, but NOT on artist_id
    # Also makes sure one artist has only artwork with a unique title but many
    # artists can have the same titled artwork. Enforced in model's validations
    add_index :artworks, [:title, :artist_id], unique: true
  end
end
