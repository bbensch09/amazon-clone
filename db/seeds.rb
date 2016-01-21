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
  brand_id: rand(10),
  category_id: rand(10),
  supplier_id: rand(10)
  }
end

100.times do
  Product.create!(unique_product)
end
