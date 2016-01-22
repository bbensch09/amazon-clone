class Product < ActiveRecord::Base
  belongs_to :category
  validates :title,:description, :image_url, :price, :inventory_quantity, :brand_id, :supplier_id, :category_id, presence: true
  validates :price, numericality: {:greater_than => 0}
  has_many :shopping_cart_items
  has_many :orders, through: :shopping_cart_items
end
