class CreateShoppingCartItems < ActiveRecord::Migration
  def change
    create_table :shopping_cart_items do |t|
      t.integer :quantity, null: false
      t.integer :product_id
      t.integer :user_id
      t.integer :order_id
      t.timestamps null: false
    end
  end
end
