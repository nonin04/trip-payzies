module ExpensesHelper

  def selectable_currency(trip)
    jpy = Currency.find_by(code: "JPY")
    if trip.currency == jpy
      [jpy]
    else
      [jpy, trip.currency]
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

end
