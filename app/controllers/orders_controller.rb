class OrdersController < ApplicationController
  before_filter :authorize_admin, :only => [:show, :edit, :update, :destroy, :index]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new]

  # GET /orders
  # GET /orders.json
  def index
   # @orders = Order.all
    #@orders = Order.paginate(:page=>params[:page], :order=>'created_at desc', :per_page => 10)
    @orders = Order.paginate(:page=>params[:page], :per_page => 10).order('created_at desc')
    respond_to do |format|
      format.html
      format.json {render json: @orders}
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_url, :notice => "购物车空"
      return
    end

    @order = Order.new
    @order.delivery_time = DateTime.now.tomorrow
    if (@user && @user.customer_info)
      @order.name = @user.customer_info.real_name
      @order.delivery_address =  @user.customer_info.resturant_address
      @order.delivery_phone = @user.customer_info.phone_number
    end


    respond_to do |format|
      format.html
      format.json {render :json => @order}
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(current_cart)
    @order.user_id = session[:user_id]

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
       # Notifier.order_received(@order).deliver
        format.html { redirect_to store_url, notice: '订单已下' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def set_user
      @user = User.find(session[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :delivery_address, :delivery_phone, :pay_type, :delivery_time)
    end
end
