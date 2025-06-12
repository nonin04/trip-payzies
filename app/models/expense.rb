class Expense < ApplicationRecord
  belongs_to :trip
  belongs_to :payer, class_name: 'Participant'

  has_many :advance_payments, dependent: :destroy
  has_many :owed_participants, through: :advance_payments, source: :participant
  accepts_nested_attributes_for :advance_payments, allow_destroy: true

  validates :trip_id, presence: true
  validates :title, presence: true, length: {maximum: 20, message: "は20字以内"}
  validates :amount, presence: true, numericality: {only_integer: true, greater_than: 0, less_than: 1_000_000 }
  validates :payer, presence: true

  validate :must_have_owed_participants_at_least_one

  private

  def must_have_owed_participants_at_least_one
    if advance_payments.empty?
      errors.add(:base, "対象者を一人以上設定してください")
    end
  end
end
