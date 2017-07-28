require 'test_helper'

class FreekassaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get freekassa_index_url
    assert_response :success
  end

end
