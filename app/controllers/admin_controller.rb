class AdminController < ApplicationController
  before_filter :authorize_admin
  def index
    @total_customers = User.count
    @total_orders = Order.count
  end
end
