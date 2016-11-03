class CreateMenus2 < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.integer :value
      t.string :category
      t.text :picture
      t.text :detail
      t.timestamps
    end
  end
end
