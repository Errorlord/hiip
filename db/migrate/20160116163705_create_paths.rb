class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.string :title
      t.text :content
      t.string :position
      t.integer :level_position
      t.integer :level
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
