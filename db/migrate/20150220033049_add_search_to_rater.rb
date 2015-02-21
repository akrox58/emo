class AddSearchToRater < ActiveRecord::Migration
  def change
    add_column :raters, :search, :integer
  end
end
