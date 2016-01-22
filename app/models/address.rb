class Address < ActiveRecord::Base
  belongs_to :user
  has_many :payment_infos
end
