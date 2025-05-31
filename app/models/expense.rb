class Expense < ApplicationRecord
  belongs_to :trip
  belongs_to :payer, class_name: 'Participant'

  has_many :advance_payments, dependent: :destroy
  accepts_nested_attributes_for :advance_payments, allow_destroy: true

  validates :trip_id, presense: true
  validates :title, presence: true, length: {maximum: 25, message: "は25字以内"}
  validates :amount, presence: true, numericality: {only_integer: true, greater_than: 0, less_than: 1_000_000 }
  validates :payer, presence: true
end
