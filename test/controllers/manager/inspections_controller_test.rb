require 'test_helper'

class Manager::InspectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manager_inspection = manager_inspections(:one)
  end

  test "should get index" do
    get manager_inspections_url
    assert_response :success
  end

  test "should get new" do
    get new_manager_inspection_url
    assert_response :success
  end

  test "should create manager_inspection" do
    assert_difference('Manager::Inspection.count') do
      post manager_inspections_url, params: { manager_inspection: { car_id: @manager_inspection.car_id, fee: @manager_inspection.fee, inspection_day: @manager_inspection.inspection_day, limit: @manager_inspection.limit } }
    end

    assert_redirected_to manager_inspection_url(Manager::Inspection.last)
  end

  test "should show manager_inspection" do
    get manager_inspection_url(@manager_inspection)
    assert_response :success
  end

  test "should get edit" do
    get edit_manager_inspection_url(@manager_inspection)
    assert_response :success
  end

  test "should update manager_inspection" do
    patch manager_inspection_url(@manager_inspection), params: { manager_inspection: { car_id: @manager_inspection.car_id, fee: @manager_inspection.fee, inspection_day: @manager_inspection.inspection_day, limit: @manager_inspection.limit } }
    assert_redirected_to manager_inspection_url(@manager_inspection)
  end

  test "should destroy manager_inspection" do
    assert_difference('Manager::Inspection.count', -1) do
      delete manager_inspection_url(@manager_inspection)
    end

    assert_redirected_to manager_inspections_url
  end
end
