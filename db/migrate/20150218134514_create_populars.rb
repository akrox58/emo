class CreatePopulars < ActiveRecord::Migration
  def change
    create_table :populars do |t|
      t.references :song, index: true
      t.integer :count

      t.timestamps null: false
    end
    add_foreign_key :populars, :songs
  end
end
