class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :user_id
      t.string :menu_id
      t.timestamps
    end
  end
end
