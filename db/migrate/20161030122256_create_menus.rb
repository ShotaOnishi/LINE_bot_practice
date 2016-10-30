class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.integer :value
      t.string :category
      t.text :picture
      t.timestamps
    end
  end
end