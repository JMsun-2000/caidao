class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  belongs_to :user

  PAYMENT_TYPES = %w(支付宝 到付 余额结算 月结)

  validates :name, :delivery_address, :delivery_phone, :pay_type, :user_id, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES

  # state 字段的取值可以按照自己喜好选择，只要能覆盖支付宝交易状态的类型就行了
  STATE = %w(opening pending paid completed canceled)
  validates :state, :inclusion => STATE

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      item.order_id = :id
      item.transaction_price = item.product.price
      line_items << item
    end
  end

  # 添加 paid? completed? 等方法
  STATE.each do |state|
    define_method "#{state}?" do
      self.state == state
    end
  end

  # 状态迁移方法

  def pend
    if opening?
      update_attribute :state, 'pending'
    end
  end

  # 只在 pending 状态可以 pay
  def pay
    if pending?
      add_plan # 业务逻辑，订单生效
      update_attribute :state, 'paid'
    end
  end

  # 只在 pending 和 paid 状态可以 complete
  def complete
    if pendding? or paid?
      add_plan if pendding? # 如果是 paid 状态，已经执行过 add_plan
      update_attribute :state, 'completed'
    end
  end

  # 只在 pending 和 paid 状态可以 cancel
  def cancel
    if pendding? or paid?
      remove_plan if paid? # 业务逻辑，取消订单
      update_attribute :state, 'canceled'
    end
  end

  def pay_url
    price_total = 0
    line_items.each do |item|
      price_total += (item.transaction_price * item.quantity)
    end


    Alipay::Service.create_partner_trade_by_buyer_url(
        :out_trade_no      => id.to_s,
        :price             => price_total,
        :quantity          => 1,
        :discount          => 0,
        :subject           => "caidao.cn #{I18n.t "蔬菜"} x 1",
        :logistics_type    => 'DIRECT',
        :logistics_fee     => '0',
        :logistics_payment => 'SELLER_PAY',
        :return_url        => Rails.application.routes.url_helpers.order_url(self, :host => 'caidao.cn'),
        :notify_url        => Rails.application.routes.url_helpers.alipay_notify_orders_url(:host => 'caidao.cn'),
        :receive_name      => 'none', # 这里填写了收货信息，用户就不必填写
        :receive_address   => 'none',
        :receive_zip       => '100000',
        :receive_mobile    => '100000000000'
    )
  end

  def send_good
    Alipay::Service.send_goods_confirm_by_platform(
        :trade_no => trade_no,
        :logistics_name => 'caidao.cn',
        :transport_type => 'DIRECT' # 无需物流
    )
  end


end
