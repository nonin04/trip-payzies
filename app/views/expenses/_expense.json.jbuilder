json.extract! expense, :id, :participant_id, :amount, :title, :payment_date, :place, :memo, :created_at, :updated_at
json.url expense_url(expense, format: :json)
