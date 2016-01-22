# SETUP
require 'faker'

User.delete_all
Product.delete_all
Category.delete_all

#CREATE ADMIN

def admin_params
  {
    email: "admin@test.com",
    password: "12345",
    admin: true
  }
end

User.create!(admin_params)

#CREATE NON-ADMINS

def unique_user
  {
  email: Faker::Internet.email,
  password: "12345"
  }
end

25.times do
  User.create!(unique_user)
end

#CREATE DEFAULT categories

def unique_category
  {
    name: Faker::Commerce.department(2)
  }
end

10.times do
  Category.create!(unique_category)
end

#CREATE DEFAULT products

def unique_product
  {
  title: Faker::Commerce.product_name,
  description: Faker::Hipster.sentence(10),
  image_url: Faker::Avatar.image,
  price: Faker::Commerce.price,
  inventory_quantity: rand(10),
  brand_id: (rand(9)+1),
  category_id: (rand(9)+1),
  supplier_id: (rand(9)+1)
  }
end

100.times do
  Product.create!(unique_product)
end

#CREATE DEFAULT orders

def order
  {
  user_id: (rand(24)+1),
  status: ['in_cart', 'ordered', 'delivered']
  }
end

30.times do
  Order.create!(order)
end

#CREATE DEFAULT shopping cart items

def shopping_cart_item
  {
  product_id: (rand(100)+1),
  quantity_id: (rand(3)+1),
  order_id: (rand(10)+1)
  }
end

30.times do
  ShoppingCartItem.create!(shopping_cart_item)
end

#CREATE DEFAULT payment info instances

def payment_info
  {
    user_id: (rand(24)+1),
    credit_card_hash: (rand(10000)).to_s,
    expiration_hash: (rand(10000)).to_s,
    name_on_card: Faker::Name.name,
    address_id: (rand(10)+1),
    cvc_hash: (rand(2)+1).to_s
  }
end

30.times do
  PaymentInfo.create!(payment_info)
end

#CREATE DEFAULT addresses

def address
  {
    street_address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip: Faker::Address.zip,
    user_id: user_id: (rand(24)+1)
  }
end

60.times do
  Address.create!(payment_info)
end
