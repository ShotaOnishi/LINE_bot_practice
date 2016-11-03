class CreateOrderGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :order_groups do |t|
      t.boolean  :enter
      t.datetime :start_time
      t.datetime :end_time
      t.integer  :table
      t.string   :user_id
      t.timestamps
    end
  end
end
