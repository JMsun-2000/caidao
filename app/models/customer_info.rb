class CustomerInfo < ActiveRecord::Base
  belongs_to :user

  validates :real_name, :phone_number, :identify_number, :resturant_address, :presence => true
end
