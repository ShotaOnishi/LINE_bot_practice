class User < ActiveRecord::Base
    belongs_to :order
    has_many :oder_groups, dependent: :destroy
end
