class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
    @cart = current_cart
  end

  def create
    user = User.authenticate(params[:name], params[:password])
    if user
      session[:user_id] = user.id
      session[:user_priority] = user.priority
      targe_url = session[:tag_url]
      session[:tag_url] = nil
      if targe_url && targe_url != login_url
        redirect_to targe_url
        return
      end

      case user.priority
        when User::ADMIN_MAP['总管理']
          redirect_to admin_url
        when User::ADMIN_MAP['菜品管理员']
          redirect_to products_url
        else
          redirect_to store_url
      end
    else
      redirect_to login_url, :alert => "未登录"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, :notice => "登出"
  end
end
