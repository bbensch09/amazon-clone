class CreatePaymentInfos < ActiveRecord::Migration
  def change
    create_table :payment_infos do |t|
      t.string :credit_card_hash, null: false
      t.string :expiration_hash, null: false
      t.string :cvc_hash, null: false
      t.string :name_on_card, null: false
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
