class Share::TripsController < ApplicationController
  skip_before_action :authenticate_user!

  before_action :set_trip

  def show
    @expenses = @trip.expenses.includes(:payer).order(payment_date: :asc, created_at: :asc)
    @balances = BalanceCalculator.new(@trip).net_balances
  end

  def insights
    @participants = @trip.participants
    balances = BalanceCalculator.new(@trip)
    @balances = balances.balances
    @net_balances = balances.net_balances
    @amount = @trip.expenses.sum(:amount)
  end

  def result
    @settlements = SettlementMatcher.new(@trip).grouped_settlements
  end

  private

  def set_trip
    @trip = Trip.find_by!(share_token: params[:share_token])
  end
end
