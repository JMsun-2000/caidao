class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authorize
  protect_from_forgery with: :exception

  protected

  def authorize
    if request.format == Mime::HTML
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, :notice => "请登录"
      end
    else
      authenticate_or_request_with_http_basic do |username, password|
        user = User.authenticate(username, password)
      end
    end
  end

  private
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
