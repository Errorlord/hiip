class AddDescriptionToPaths < ActiveRecord::Migration
  def change
    add_column :paths, :parent, :string
  end
end
