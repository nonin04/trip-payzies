class TripsController < ApplicationController
  before_action :set_trip, only: [ :show, :edit, :update, :destroy, :result, :settle ]

  def index
    @trips = current_user.trips.order(departure_date: :desc)
  end

  def show
    @participants = @trip.participants
    @expenses = @trip.expenses.includes(:payer).order(payment_date: :desc)
  end

  def new
    @trip = Trip.new
    10.times { @trip.participants.build }
  end

  def create
    @trip = current_user.trips.build(trip_and_participants_params)
    if @trip.save
      redirect_to trip_path(@trip)
    else
      flash.now[:alert] = @trip.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      flash[:notice] = "更新しました。"
      redirect_to trip_path(@trip)
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trip.expenses.destroy_all
    @trip.destroy
    redirect_to trips_path, notice: "旅行を1件削除しました"
  end

  def result
  end

  def settle
    if @trip.update(settlement_status: :settled)
       redirect_to trip_path(@trip), notice: "精算が完了しました"
    else
      flash.now[:alert] = "ステータスを更新できませんでした。"
      render :result, status: :unprocessable_entity
    end
  end

  private

  def set_trip
    @trip = current_user.trips.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(
      :title, :group_id, :departure_date)
  end

  def trip_and_participants_params
    params.require(:trip).permit(
      :title, :group_id, :departure_date,
      participants_attributes: [ :name ]
      )
  end
end
