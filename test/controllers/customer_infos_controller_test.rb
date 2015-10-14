require 'test_helper'

class CustomerInfosControllerTest < ActionController::TestCase
  setup do
    @customer_info = customer_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_info" do
    assert_difference('CustomerInfo.count') do
      post :create, customer_info: { comment_info: @customer_info.comment_info, identify_number: @customer_info.identify_number, phone_number: @customer_info.phone_number, real_name: @customer_info.real_name, resturant_address: @customer_info.resturant_address, user_id: @customer_info.user_id }
    end

    assert_redirected_to customer_info_path(assigns(:customer_info))
  end

  test "should show customer_info" do
    get :show, id: @customer_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_info
    assert_response :success
  end

  test "should update customer_info" do
    patch :update, id: @customer_info, customer_info: { comment_info: @customer_info.comment_info, identify_number: @customer_info.identify_number, phone_number: @customer_info.phone_number, real_name: @customer_info.real_name, resturant_address: @customer_info.resturant_address, user_id: @customer_info.user_id }
    assert_redirected_to customer_info_path(assigns(:customer_info))
  end

  test "should destroy customer_info" do
    assert_difference('CustomerInfo.count', -1) do
      delete :destroy, id: @customer_info
    end

    assert_redirected_to customer_infos_path
  end
end
