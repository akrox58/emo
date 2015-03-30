class CreateSongs < ActiveRecord::Migration
  def change
    
    create_table :songs do |t|
      t.string :name
      t.integer :mood_id
      t.integer :artist_id
      t.string :audio_file_name
      t.string :audio_content_type
      t.integer :audio_file_size
      t.datetime :audio_updated_at
      t.datetime :created_at
      t.datetime :updated_at
      t.references :artist, index: true
      t.references :mood, index: true

      t.timestamps null: false
    end
    add_foreign_key :songs, :artists
    add_foreign_key :songs, :moods
  end
end
