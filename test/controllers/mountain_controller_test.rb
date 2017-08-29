require 'test_helper'

class MountainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mountain_index_url
    assert_response :success
  end

end
