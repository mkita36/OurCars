require 'test_helper'

class UsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @use = uses(:one)
  end

  test "should get index" do
    get uses_url
    assert_response :success
  end

  test "should get new" do
    get new_use_url
    assert_response :success
  end

  test "should create use" do
    assert_difference('Use.count') do
      post uses_url, params: { use: { car_id: @use.car_id, destination: @use.destination, odometer: @use.odometer, oil_change: @use.oil_change, refueling_amount: @use.refueling_amount, use_day: @use.use_day, user_id: @use.user_id, wash: @use.wash } }
    end

    assert_redirected_to use_url(Use.last)
  end

  test "should show use" do
    get use_url(@use)
    assert_response :success
  end

  test "should get edit" do
    get edit_use_url(@use)
    assert_response :success
  end

  test "should update use" do
    patch use_url(@use), params: { use: { car_id: @use.car_id, destination: @use.destination, odometer: @use.odometer, oil_change: @use.oil_change, refueling_amount: @use.refueling_amount, use_day: @use.use_day, user_id: @use.user_id, wash: @use.wash } }
    assert_redirected_to use_url(@use)
  end

  test "should destroy use" do
    assert_difference('Use.count', -1) do
      delete use_url(@use)
    end

    assert_redirected_to uses_url
  end
end
