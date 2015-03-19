class CreateReccommenders < ActiveRecord::Migration
  def change
    create_table :reccommenders do |t|
      t.integer :user_id
      t.integer :happy
      t.integer :sad
      t.integer :angry
      t.integer :fear
      t.integer :surprise
      t.references :mood, index: true
      t.timestamps null: false
    end
    add_foreign_key :reccommenders, :raters
  end
end
