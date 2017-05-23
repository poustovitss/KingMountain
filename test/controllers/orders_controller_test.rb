require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get orders_index_url
    assert_response :success
  end

  test "should get show" do
    get orders_show_url
    assert_response :success
  end

  test "should get new" do
    get orders_new_url
    assert_response :success
  end

  test "should get create" do
    get orders_create_url
    assert_response :success
  end

  test "should get sucess" do
    get orders_sucess_url
    assert_response :success
  end

  test "should get update" do
    get orders_update_url
    assert_response :success
  end

  test "should get pending" do
    get orders_pending_url
    assert_response :success
  end

  test "should get fail" do
    get orders_fail_url
    assert_response :success
  end

  test "should get order_params" do
    get orders_order_params_url
    assert_response :success
  end

end
