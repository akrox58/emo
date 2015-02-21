class RemoveMoodrateIdFromProducts < ActiveRecord::Migration
  def change
    remove_column :raters, :moodrate_id, :number
    add_reference :raters, :moods, index: true
  end

def self.up
	rename_column :raters, :moodrate, :mood_id
end

end
