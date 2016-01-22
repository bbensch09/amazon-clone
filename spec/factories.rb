FactoryGirl.define do  factory :payment_info do
    
  end
  factory :address do
    
  end
  factory :order do
    
  end
  factory :shopping_cart_item do
    
  end

  factory :product do
    title {Faker::App.name}
    description {Faker::Commerce.product_name}
    image_url {Faker::Internet.domain_name}
    price {rand(100)+1}
    inventory_quantity {rand(20)}
    brand_id {rand(10)+1}
    category_id {rand(10)+1}
    supplier_id {rand(10)+1}
  end

  factory :category do
    name {Faker::Company.suffix}
  end

  factory :user do
    email {Faker::Internet.email}
    password {Faker::Internet.password(5,8)}
    factory :admin do
      admin {true}
    end
  end

end
