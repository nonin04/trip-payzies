class ExpensesController < ApplicationController
  def show
    @trip = current_user.trips.find(params[:trip_id])
    @expense = @trip.expenses.find(params[:id])
    @participants = @trip.participants
    
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  
  def expense_params
    params.require(:expense).permit(:trip_id, :payer_id, :amount, :title, :payment_date, :place, :memo)
  end
end
