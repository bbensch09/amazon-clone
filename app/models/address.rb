class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :payment_info
end
