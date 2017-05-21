require 'test_helper'

class ImprovesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get improves_index_url
    assert_response :success
  end

end
