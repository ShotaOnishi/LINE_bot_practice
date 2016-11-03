class UserOrders < ActiveRecord::Base
  belongs_to :user_id
  belongs_to :order_group
end
