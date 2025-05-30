class ExpensesController < ApplicationController
  def show
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
