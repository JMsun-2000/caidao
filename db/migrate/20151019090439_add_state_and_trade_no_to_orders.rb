class AddStateAndTradeNoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :state, :string, :default => 'opening'
    add_column :orders, :trade_no, :integer #支付宝交易号
  end
end
