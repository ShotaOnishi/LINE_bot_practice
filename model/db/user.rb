class User < ActiveRecord::Base
    has_many :user_orders
    has_many :order_groups, through: :user_orders
end
