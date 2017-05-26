require 'test_helper'

class GetmoneysControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get getmoneys_new_url
    assert_response :success
  end

  test "should get create" do
    get getmoneys_create_url
    assert_response :success
  end

end
