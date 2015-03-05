class RemovenewreFromProducts < ActiveRecord::Migration
  def change
   remove_column :raters, :moods_id, :number
    add_reference :raters, :mood, index: true
end
end
