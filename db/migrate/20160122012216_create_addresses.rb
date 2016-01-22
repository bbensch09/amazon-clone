class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_address, null: false
      t.string :street_address2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
