class Order < ActiveRecord::Base
  has_many :shopping_cart_items
  belongs_to :user
  belongs_to :payment_info
end
