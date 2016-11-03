class Order < ActiveRecord::Base
    has_many :menus, dependent: :destroy
    has_many :users, dependent: :destroy
end
