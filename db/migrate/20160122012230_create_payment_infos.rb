class CreatePaymentInfos < ActiveRecord::Migration
  def change
    create_table :payment_infos do |t|

      t.timestamps null: false
    end
  end
end
