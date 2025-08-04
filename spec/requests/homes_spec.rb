require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    it "LPページが正常に表示される" do
      get unauthenticated_root_path
      expect(response).to have_http_status(200)
    end
  end
end
