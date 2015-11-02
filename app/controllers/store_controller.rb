class StoreController < ApplicationController
  skip_before_filter :authorize

  def index
    @filter = params[:product_filter]
    if @filter
      filter_sub = params[:product_sub_filter]
      if filter_sub
        @products = Product.where(:product_type => @filter, :sub_type => filter_sub).to_a
      else
        @products = Product.where(:product_type => @filter).to_a
      end

      @sub_filters = Product.where(:product_type => @filter).uniq.pluck(:sub_type)
    else
      @products = Product.all
    end
    @product_filters = Product.all.uniq.pluck(:product_type)
    @cart = current_cart
  end
end
