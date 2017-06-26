require 'test_helper'

class PayeersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get payeers_new_url
    assert_response :success
  end

  test "should get create" do
    get payeers_create_url
    assert_response :success
  end

end
