module ExpensesHelper
  def selectable_currency(trip)
    jpy = Currency.find_by(code: "JPY")
    if trip.currency == jpy
      [ jpy ]
    else
      [ jpy, trip.currency ]
    end
  end

  def trip_in_japan?(trip)
    trip.currency == Currency.find_by(code: "JPY")
  end

  def formatted_amount_local(expense)
    jpy = Currency.find_by(code: "JPY")
    if expense.currency == jpy
      number_with_delimiter(expense.amount_local.to_i)
    else
      number_with_precision(expense.amount_local, precision: expense.currency.decimal_position, delimiter: ",")
    end
  end


  def expense_amount_color(expense)
    jpy = Currency.find_by(code: "JPY")
    expense.currency == jpy ? "expense-accent-color-jpy" : "expense-accent-color-foreign"
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
