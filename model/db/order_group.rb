class OrderGroup < ActiveRecord::Base
    has_many :user_orders
    has_many :users, through: :user_orders
end
