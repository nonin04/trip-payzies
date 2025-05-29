class AdvancePayment < ApplicationRecord
  belongs_to :expense
  belongs_to :participant

  validates :participant_id, uniqueness: {scope: :expense_id, message: "は既選択済みです。"} 
  
end
