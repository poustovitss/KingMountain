require 'test_helper'

class GetbalancesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get getbalances_new_url
    assert_response :success
  end

  test "should get create" do
    get getbalances_create_url
    assert_response :success
  end

end
