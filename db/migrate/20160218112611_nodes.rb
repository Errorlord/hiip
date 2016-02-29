class Nodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
        t.string :title
        t.text :content
        t.string :position
        t.string :parent
        t.datetime :created_at
        t.datetime :updated_at
    end
  end
end