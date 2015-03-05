class AddplaytoRaters < ActiveRecord::Migration
  def change
  add_column :raters, :play, :integer
 end
end
