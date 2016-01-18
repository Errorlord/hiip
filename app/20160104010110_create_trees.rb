class CreateTrees < ActiveRecord::Migration
  def change
    create_table :trees do |t|
      t.string :title
      t.text :description
      t.string :tree_location
      t.integer :tree_id
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
