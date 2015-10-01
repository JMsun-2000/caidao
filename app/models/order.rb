class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy

  PAYMENT_TYPES = ["支付宝", "余额结算", "月结"]

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      item.order_id = :id
      line_items << item
    end
  end
end
