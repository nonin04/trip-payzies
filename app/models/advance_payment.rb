class AdvancePayment < ApplicationRecord
  belongs_to :expense
  belongs_to :participant

  validates :participant_id, presence: true
  validates :participant_id, uniqueness: { scope: :expense_id, message: "は既選択済みです。" }
  validates :amount, numericality: { only_integer: true }


  private

  def auto_fill_amout
  end
end
