class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false
      t.string :title, null: false
      t.integer :year, null: false
      t.boolean :live, null: false, default: false
      
      t.timestamps
    end

    
    # index on mutiple columns
    # search by both :band_id and [:band_id, :title] (order matters!)
    add_index :albums, %i(band_id title), unique: true
    
    add_index :albums, :title
  end
end
