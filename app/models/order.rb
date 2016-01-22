class Order < ActiveRecord::Base
  has_many :shopping_cart_items
  belongs_to :user
  belongs_to :payment_info
  belongs_to :address


  def order_total
    sum = 0
    self.shopping_cart_items.each do |item|
      sum += item.product.price * item.quantity
    end
    sum
  end

end
