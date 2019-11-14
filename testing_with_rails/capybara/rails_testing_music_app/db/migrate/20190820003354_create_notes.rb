class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.integer :user_id, null: false
      t.integer :track_id, null: false
      t.text :comment, null: false

      t.timestamp
    end

    add_index :notes, :track_id
    add_index :notes, :user_id
  end
end
