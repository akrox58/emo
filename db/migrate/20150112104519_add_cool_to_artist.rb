class AddCoolToArtist < ActiveRecord::Migration

def self.down
    change_table :users do |t|
      t.remove :song_id
    end
  end
end
