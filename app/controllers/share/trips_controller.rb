class Share::TripsController < ApplicationController
  skip_before_action :authenticate_user!

  before_action :set_trip

  def show
    @expenses_by_date = @trip.expenses.includes(:payer, :currency).order(payment_date: :asc, created_at: :asc).group_by(&:payment_date)
  end

  def insights
    if @trip.expenses.empty?
       flash.now[:alert] = "精算記録がありません。"
    end
    @balances = BalanceCalculator.new(@trip).balances
    @participants = @trip.participants
  end

  def result
    if @trip.expenses.empty?
      redirect_to share_trip_path(@trip), alert: "精算記録がありません。"
    else
      @settlements = TripDecorator.new(@trip).grouped_settlements
    end
  end

  private

  def set_trip
    @trip = Trip.find_by!(share_token: params[:share_token])
  end
end
