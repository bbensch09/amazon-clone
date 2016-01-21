class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :image_url, null: false
      t.decimal  "price", null: false, :scale => 2, :precision => 10
      t.integer :inventory_quantity
      t.references :brand
      t.references :supplier
      t.references :category
      t.timestamps null: false
    end
  end
end
