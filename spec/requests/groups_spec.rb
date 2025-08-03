require 'rails_helper'

RSpec.describe "Groups", type: :request do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:jpy_currency) { create(:currency, :jpy) }
  let(:usd_currency) { create(:currency, :usd) }
  let!(:trip) { create(:trip, :with_participants, user: user, group: group, currency: jpy_currency, participants_count: 3) }

  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end


  # it "バリデーションエラーだとエラーになる" do
  #   post members_for_group_groups_path(trip), params: { group_id: trip.group.id }
  #   expect(response).to have_http_status(:ok)
  #   json = JSON.parse(response.body)
  #   name = trip.participants.first.name
  #   expect(json).to include(name)
  # end
end
