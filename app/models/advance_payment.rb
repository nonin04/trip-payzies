class AdvancePayment < ApplicationRecord
  belongs_to :expense
  belongs_to :participant
end
