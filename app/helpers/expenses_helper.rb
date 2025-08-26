module ExpensesHelper

  def jpy_currency
     @jpy_currency ||= Currency.find_by(code: "JPY") 
  end

  def selectable_currency(trip)
    if trip.currency == jpy_currency
      [ jpy_currency ]
    else
      [ jpy_currency, trip.currency ]
    end
  end

  def trip_in_japan?(trip)
  end

  def formatted_amount_local(expense)
    if expense.currency == jpy_currency
      number_with_delimiter(expense.amount_local.to_i)
    else
      number_with_precision(expense.amount_local, precision: expense.currency.decimal_position, delimiter: ",")
    end
  end

  def about_rate_message(expense)
    payment_date = expense.payment_date
    latest_time = [ expense.created_at.to_time, expense.updated_at.to_time ].max
    if payment_date == Date.current && latest_time < Time.current.change(hour: 10, min: 0, sec: 0)
      "#{ (payment_date - 2.day).strftime('%m/%d') }の為替レートが適用されています。"
    else
      "#{ (payment_date - 1.day).strftime('%m/%d') }の為替レートが適用されています。"
    end
  end
end
