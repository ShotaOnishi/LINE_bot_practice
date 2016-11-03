class Shop < ActiveRecord::Base
  has_many :menus, dependent: :destroy
end
