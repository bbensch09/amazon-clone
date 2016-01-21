class Product < ActiveRecord::Base
  belongs_to :category
  validates :title,:description, :image_url, :price, :inventory_quantity, :brand_id, :supplier_id, :category_id, presence: true
  validates :price, numericality: {:greater_than => 0}
end
