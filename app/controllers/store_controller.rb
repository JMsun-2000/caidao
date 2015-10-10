class StoreController < ApplicationController
  skip_before_filter :authorize

  def index
    filter = params[:product_filter]
    if filter
      @products = Product.where(:product_type => filter).to_a
    else
      @products = Product.all
    end
    @product_filters = Product.all.uniq.pluck(:product_type)
    @cart = current_cart
  end
end
