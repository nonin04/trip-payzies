require "test_helper"

class Share::ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get share_expenses_show_url
    assert_response :success
  end
end
