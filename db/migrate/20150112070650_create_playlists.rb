class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.references :mood, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :playlists, :moods
    add_foreign_key :playlists, :users
  end
end
