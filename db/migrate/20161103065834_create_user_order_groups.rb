class CreateUserOrderGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :user_order_groups do |t|
      t.integer :user_id
      t.integer :order_group_id
      t.timestamps
    end
  end
end
