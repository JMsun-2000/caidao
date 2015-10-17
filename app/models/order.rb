class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  belongs_to :user

  PAYMENT_TYPES = ["到付", "余额结算", "月结"]

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      item.order_id = :id
      item.transaction_price = item.product.price
      line_items << item
    end
  end

  validates :name, :delivery_address, :delivery_phone, :pay_type, :user_id, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES
end
