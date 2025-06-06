class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def new
    @expense = Expense.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @expense.destroy
    redirect_to trip_path(@trip), notice: "立替記録を一件削除しました"
  end

  private
  def set_expense
    @trip = current_user.trips.find(params[:trip_id])
    @expense = @trip.expenses.includes(:payer).find(params[:id])
    @participants = @trip.participants
    @advance_payments = @expense.advance_payments.includes(:participant)
  end

  def expense_params
    params.require(:expense).permit(
      :payer_id, :amount, :title, :payment_date, :place, :memo,
      advance_payments_attributes:[:participant_id, :_destroy]
      )
  end
end
