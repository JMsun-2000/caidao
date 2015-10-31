require 'test_helper'

class CroplandsControllerTest < ActionController::TestCase
  setup do
    @cropland = croplands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:croplands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cropland" do
    assert_difference('Cropland.count') do
      post :create, cropland: { area_unit: @cropland.area_unit, land_area: @cropland.land_area, land_output: @cropland.land_output, land_production: @cropland.land_production, latest_seeding_date: @cropland.latest_seeding_date, output_cycle: @cropland.output_cycle, output_unit: @cropland.output_unit, product_id: @cropland.product_id, user_id: @cropland.user_id }
    end

    assert_redirected_to cropland_path(assigns(:cropland))
  end

  test "should show cropland" do
    get :show, id: @cropland
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cropland
    assert_response :success
  end

  test "should update cropland" do
    patch :update, id: @cropland, cropland: { area_unit: @cropland.area_unit, land_area: @cropland.land_area, land_output: @cropland.land_output, land_production: @cropland.land_production, latest_seeding_date: @cropland.latest_seeding_date, output_cycle: @cropland.output_cycle, output_unit: @cropland.output_unit, product_id: @cropland.product_id, user_id: @cropland.user_id }
    assert_redirected_to cropland_path(assigns(:cropland))
  end

  test "should destroy cropland" do
    assert_difference('Cropland.count', -1) do
      delete :destroy, id: @cropland
    end

    assert_redirected_to croplands_path
  end
end
