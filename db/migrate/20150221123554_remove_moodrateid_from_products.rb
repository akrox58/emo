class RemoveMoodrateidFromProducts < ActiveRecord::Migration
  def change
    remove_column :raters, :moodrate, :integer
  end
end
