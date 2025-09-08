class Participant < ApplicationRecord
  belongs_to :trip
  has_many :paid_expenses, class_name: "Expense", dependent: :restrict_with_error, foreign_key: "payer_id"

  has_many :advance_payments, dependent: :restrict_with_error
  has_many :owed_expenses, through: :advance_payments, source: :expense

  validates :name, presence: true, length: { maximum: 15, message: "は15字以内で入力してください" }
  validates :name, uniqueness: { scope: :trip_id, message: "が既に存在します。" }

  def paid_total
    paid_expenses.sum(:amount)
  end

  def owed_total
    advance_payments.sum(:amount)
  end

  def difference
    paid_total - owed_total
  end

  def creditor?
    difference > 0
  end

  def debtor?
    difference < 0
  end
end
