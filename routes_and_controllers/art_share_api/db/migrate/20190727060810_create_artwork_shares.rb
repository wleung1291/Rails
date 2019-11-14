class CreateArtworkShares < ActiveRecord::Migration[5.2]
  def change
    # The artwork_shares table is a join table. Its whole purpose is to link a 
    # User (the person viewing the artwork) with an Artwork.
    create_table :artwork_shares do |t|
      t.integer :artwork_id, null: false
      t.integer :viewer_id, null: false

      t.timestamps
    end

    add_index :artwork_shares, :artwork_id
    add_index :artwork_shares, :viewer_id
    add_index :artwork_shares, [:artwork_id, :viewer_id], unique: true
  end
end
