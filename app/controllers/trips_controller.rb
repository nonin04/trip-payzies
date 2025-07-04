class TripsController < ApplicationController
  before_action :set_trip, only: [ :show, :edit, :update, :destroy, :insights, :result, :settle, :unsettle ]

  def index
    @user_trips = current_user.trips
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
       redirect_to trip_path(@trip), notice: "精算状況：精算済みに変更しました"
    else
      flash.now[:alert] = "ステータスを更新できませんでした。"
      render :result, status: :unprocessable_entity
    end
  end

  def unsettle
    if @trip.update(settlement_status: :unsettled)
       redirect_to trip_path(@trip), notice: "精算状況：未精算に変更しました"
    else
      flash.now[:alert] = "ステータスを更新できませんでした。"
      render :result, status: :unprocessable_entity
    end
  end


  def members_for_group
    group_id = params[:group_id]
    selected_group = current_user.groups.find_by(id: group_id)
    render json: { names: selected_group.members.pluck(:name) }
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
