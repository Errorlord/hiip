class CreateStructure < ActiveRecord::Migration
  def change
    create_table :structures do |t|
      t.string :title
      t.text :description
      t.integer :position
      t.integer :parent_position
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
