class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.text :picture
      t.text :detail
      t.string :category
      t.integer :price
      t.timestamps
    end
  end
end
