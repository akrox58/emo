class CreateRaters < ActiveRecord::Migration
  def change
    create_table :raters do |t|
      t.references :user, index: true
      t.references :song, index: true
      t.integer :count
      t.integer :moodrate

      t.timestamps null: false
    end
    add_foreign_key :raters, :users
    add_foreign_key :raters, :songs
  end
end
