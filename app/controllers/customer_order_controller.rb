class CustomerOrderController < ApplicationController
  def index
    @orders = Order.where(:user_id => session[:user_id]).to_a
  end
end
