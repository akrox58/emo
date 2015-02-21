class AddMoodRefToRaters < ActiveRecord::Migration
  def change
    add_reference :raters, :moodrate, index: true
    add_foreign_key :raters, :moods
  end
end
