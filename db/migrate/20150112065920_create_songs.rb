class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.references :mood, index: true
      t.references :artist, index: true
      t.has_attached_file :audio

      t.timestamps null: false
    end

    add_foreign_key :songs, :moods
    add_foreign_key :songs, :artists
  end
end
