class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.string :mood

      t.timestamps null: false
    end
  end
end
