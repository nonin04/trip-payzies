class Participant < ApplicationRecord
  belongs_to :trip
  has_many :paid_expenses, class_name: 'Expense', dependent: :destroy, foregin_key: 'payer_id'

  has_many :advance_payments, dependent: :destroy
  
  validates :name, presence: true, length: {maximum: 12, message: "は12字以内"}
  validates :name, uniqueness: {scope: :trip_id, message: "が既に存在します。"}

end
