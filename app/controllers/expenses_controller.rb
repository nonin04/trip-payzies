class ExpensesController < ApplicationController
  before_action :set_expense, only: [ :show, :edit, :update, :destroy ]
  
  def show
  end

  def new
    @trip = current_user.trips.find(params[:trip_id])
    @expense = @trip.expenses.build
  end

  def create
    @trip = current_user.trips.find(params[:trip_id])
    @expense = @trip.expenses.build(expense_params)

    if @expense.save
      ExpenseAmountDistributor.new(@expense).call
      @trip.reset_settlement_status
      
      redirect_to trip_path(@trip), notice: I18n.t('flash.expense.success.create')
    else
      flash.now[:alert] = I18n.t('flash.expense.failed.create')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    success = false
    ActiveRecord::Base.transaction do
      # advance_paymentsは新しく送られてきたパラメータで再作成する
      @expense.advance_payments.destroy_all
      if @expense.update(expense_params)
        ExpenseAmountDistributor.new(@expense).call
        @trip.reset_settlement_status
        success = true
      else
        raise ActiveRecord::Rollback
      end
    end

    if success
      flash[:notice] = I18n.t('flash.expense.success.update')
      redirect_to trip_path(@trip)
    else
      flash.now[:alert] = I18n.t('flash.expense.failed.update')
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @expense.destroy
    redirect_to trip_path(@trip), notice: I18n.t('flash.expense.success.delete')
  end

  private
  def set_expense
    @trip = current_user.trips.find(params[:trip_id])
    @expense = @trip.expenses.includes(:payer).find(params[:id])
    @owed_participants = @expense.owed_participants
    @advance_payments = @expense.advance_payments.includes(:participant)
  end

  def expense_params
    params.require(:expense).permit(
      :payer_id, :amount, :title, :payment_date, :place, :memo,
      advance_payments_attributes: [ :id, :participant_id ]
      )
  end
end
