class TripsController < ApplicationController
  before_action :set_trip, only: [ :show, :edit, :update, :destroy, :insights, :result, :settle, :unsettle ]

  def index
    @user_trips = current_user.trips.includes(:currency)
    @q = @user_trips.ransack(params[:q])
    @trips = @q.result(distinct: true).includes(:group).order(departure_date: :desc)
  end

  def show
    @expenses = @trip.expenses.includes(:payer).order(payment_date: :asc, created_at: :asc)
    @balances = BalanceCalculator.new(@trip).net_balances
  end

  def new
    @trip = Trip.new
    10.times { @trip.participants.build }
  end

  def create
    @trip = current_user.trips.build(trip_and_participants_params)
    if @trip.save
      redirect_to trip_path(@trip)
    flash[:notice] = I18n.t("flash.trip.success.create")
    else
      flash.now[:alert] = @trip.errors.full_messages.join("、")
      (10 - @trip.participants.size).times { @trip.participants.build }
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      flash[:notice] = I18n.t("flash.trip.success.update")
      redirect_to trip_path(@trip)
    else
      flash.now[:alert] = @trip.errors.full_messages.join("、")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trip.expenses.destroy_all
    @trip.destroy
    redirect_to trips_path, notice: I18n.t("flash.trip.success.delete")
  end


  def insights
    balances = BalanceCalculator.new(@trip)
    @balances = balances.balances
    @net_balances = balances.net_balances
  end

  def result
    @settlements = SettlementMatcher.new(@trip).grouped_settlements
  end

  def settle
    if @trip.update(settlement_status: :settled)
       redirect_to trip_path(@trip), notice: I18n.t("flash.settle.settled")
    else
      flash.now[:alert] = I18n.t("flash.settle.update_failed")
      render :result, status: :unprocessable_entity
    end
  end

  def unsettle
    if @trip.update(settlement_status: :unsettled)
       redirect_to trip_path(@trip), notice: I18n.t("flash.settle.unsettled")
    else
      flash.now[:alert] = I18n.t("flash.settle.update_failed")
      render :result, status: :unprocessable_entity
    end
  end

  private

  def set_trip
    @trip = current_user.trips.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(
      :title, :group_id, :departure_date, :currency_id)
  end

  def trip_and_participants_params
    params.require(:trip).permit(
      :title, :group_id, :departure_date, :currency_id,
      participants_attributes: [ :name ]
      )
  end
end
