# SETUP
require 'faker'

User.delete_all
Product.delete_all
Category.delete_all
PaymentInfo.delete_all
Order.delete_all
Address.delete_all

#Default values

def admin_params
  {
    email: "admin@test.com",
    password: "12345",
    admin: true
  }
end

def unique_user
  {
  email: Faker::Internet.email,
  password: "12345"
  }
end

def unique_product
  {
  title: Faker::Commerce.product_name,
  description: Faker::Hipster.sentence(10),
  image_url: Faker::Avatar.image,
  price: Faker::Commerce.price,
  inventory_quantity: rand(10),
  brand_id: (rand(9)+1),
  supplier_id: (rand(9)+1)
  }
end

def unique_category
  {
    name: Faker::Commerce.department(2)
  }
end

def order
  {
  status: ['in_cart', 'ordered', 'delivered'].sample
  }
end

def shopping_cart_item
  {
  product_id: (rand(100)+1),
  quantity: (rand(3)+1),
  }
end

def payment_info
  {
    credit_card_hash: (rand(10000)).to_s,
    expiration_hash: (rand(10000)).to_s,
    name_on_card: Faker::Name.name,
    cvc_hash: (rand(2)+1).to_s
  }
end

def address
  {
    street_address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip: Faker::Address.zip
  }
end

#CREATE ADMINS
User.create!(admin_params)

#CREATE DEFAULT categories
10.times do
  category = Category.create!(unique_category)
  end

all_categories = Category.all

#CREATE NON-ADMINS
10.times do
  user_instance = User.create!(unique_user)

  #CREATE DEFAULT addresses
  3.times do
    address_instance = Address.create!(address)
    user_instance.addresses << address_instance

    #CREATE DEFAULT payment info instances
    2.times do
      payment_info_instance = PaymentInfo.create!(payment_info)
      user_instance.payment_infos << payment_info_instance
      address_instance.payment_infos << payment_info_instance
    end
  end

  #CREATE DEFAULT orders
  30.times do
    order_instance = Order.create!(order)
    user_instance.orders << order_instance

    #CREATE products in order
    5.times do
      product_instance = Product.new(unique_product)
      all_categories.sample.products << product_instance

      #CREATE shopping cart items
      5.times do
        item_instance = ShoppingCartItem.create!(shopping_cart_item)
        product_instance.shopping_cart_items << item_instance
        user_instance.shopping_cart_items << item_instance
        order_instance.shopping_cart_items << item_instance
      end
    end
  end

  #CREATE products in not in order
  5.times do
    product_instance = Product.new(unique_product)
    all_categories.sample.products << product_instance

    #CREATE DEFAULT shopping cart items

    5.times do
      ShoppingCartItem.create!(shopping_cart_item)
      item_instance = ShoppingCartItem.create!(shopping_cart_item)
      product_instance.shopping_cart_items << item_instance
      user_instance.shopping_cart_items << item_instance
    end
  end
end














