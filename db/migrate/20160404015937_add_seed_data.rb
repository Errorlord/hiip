class AddSeedData < ActiveRecord::Migration
  def change
    Node.create(title: "1", content: "1", position: "1")
  end
end
