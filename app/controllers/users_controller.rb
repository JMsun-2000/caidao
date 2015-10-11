class UsersController < ApplicationController
  before_filter :authorizeAdmin

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)
    respond_to do |format|
      format.html
      format.json {render json: @users}
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "用户 #{@user.name} 创建成功" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :action => "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: "用户 #{@user.name} 信息已更新." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
   # @user.destroy
    @user = User.find(params[:id])
    notice_info = "删除操作完成";
    begin
      @user.destroy
      notice_info = "用户 #{@user.name} 已被删除"
    rescue Exception => e
      notice_info = e.message
    end

    respond_to do |format|
      format.html { redirect_to users_url, notice: notice_info }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :openpassword, :openpassword_confirmation, :hashed_password, :salt, :priority_name, :priority)
    end
end
