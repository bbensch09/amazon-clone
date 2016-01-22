class PaymentInfo < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  belongs_to :address
end
