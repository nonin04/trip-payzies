class Expense < ApplicationRecord
  belongs_to :participant
  belongs_to :trip
  belongs_to :payer, class_name: 'Participant'
end
