class AddSongidFromProducts < ActiveRecord::Migration
  def change

   remove_column :playlists, :name, :string
    add_reference :playlists, :song, index: true
  end
end
