class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    user = User.authenticate(params[:name], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, :alert => "未登录"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, :notice => "登出"
  end
end