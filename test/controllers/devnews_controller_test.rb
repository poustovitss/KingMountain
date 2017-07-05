require 'test_helper'

class DevnewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get devnews_index_url
    assert_response :success
  end

end
