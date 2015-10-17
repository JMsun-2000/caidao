class AddLogisticsStatusAndDeliveryTimeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :logistics_status, :integer, :default => 0
    add_column :orders, :delivery_time, :datetime, :default => DateTime.now.tomorrow
  end
end
