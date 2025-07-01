require "test_helper"

class Share::TripsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get share_trips_show_url
    assert_response :success
  end
end
