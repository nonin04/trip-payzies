class Share::ExpensesController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @trip = Trip.find_by!(share_token: params[:share_token])
    @expense = @trip.expenses.includes(:payer).find(params[:id])
  end
end
