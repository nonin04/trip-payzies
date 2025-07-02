class Share::ExpensesController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @trip = Trip.find_by!(share_token: params[:trip_share_token])
    @expense = @trip.expenses.includes(:payer).find(params[:id])
    @owed_participants = @expense.owed_participants
    @advance_payments = @expense.advance_payments.includes(:participant)
  end
end
