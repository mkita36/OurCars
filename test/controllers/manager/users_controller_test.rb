require 'test_helper'

class Manager::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manager_users_index_url
    assert_response :success
  end

  test "should get new" do
    get manager_users_new_url
    assert_response :success
  end

  test "should get edit" do
    get manager_users_edit_url
    assert_response :success
  end

  test "should get create" do
    get manager_users_create_url
    assert_response :success
  end

  test "should get update" do
    get manager_users_update_url
    assert_response :success
  end

  test "should get destroy" do
    get manager_users_destroy_url
    assert_response :success
  end

end
