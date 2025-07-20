class Expense < ApplicationRecord
  
  include ActionView::Helpers::NumberHelper

  belongs_to :trip
  belongs_to :payer, class_name: "Participant"
  belongs_to :currency

  has_many :advance_payments, dependent: :destroy
  has_many :owed_participants, through: :advance_payments, source: :participant
  accepts_nested_attributes_for :advance_payments, allow_destroy: true

  before_validation :set_default_currency
  before_validation :convert_amount_to_jpy

  validates :trip_id, presence: true
  validates :currency_id, presence: true
  validates :title, presence: true, length: { maximum: 25, message: "は25字以内で入力してください" }
  validates :amount_local, presence: true, numericality: { greater_than: 0 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :payer, presence: true
  validates :payment_date, presence: true

  validate :owed_particpants_must_belongs_to_expense
  validate :must_have_owed_participants_at_least_one
  validate :payment_date_cannot_be_in_the_future

  private

  def owed_particpants_must_belongs_to_expense
    advance_payments.each do |ap|
      if !trip.participant_ids.include?(ap.participant_id)
        errors.add(:base, "この旅行の参加者以外は選択できません")
      end
    end
  end

  def must_have_owed_participants_at_least_one
    if advance_payments.empty?
      errors.add(:base, "対象者を一人以上設定してください")
    end
  end

  def payment_date_cannot_be_in_the_future
    return if trip.currency == Currency.find_by(code: "JPY")
    return if currency == Currency.find_by(code: "JPY")
    return if payment_date >= Date.new(2025, 7, 19) && payment_date <= Date.current
    errors.add(:payment_date, "2025/7/19~今日までの日付を選択してください")
  end

  def set_default_currency
    self.currency_id ||= Currency.find_by!(code: "JPY").id
  end

  def convert_amount_to_jpy
    if payment_date == Date.current && Time.current < Time.current.change(hour: 10, min: 0, sec: 0)
      exchange_rate = ExchangeRate.find_by(rate_date: payment_date - 2.day, currency_id: currency_id)&.rate || 1   
      self.amount = (amount_local.to_d / exchange_rate).round(0)
    else
      exchange_rate = ExchangeRate.find_by(rate_date: payment_date - 1.day, currency_id: currency_id)&.rate || 1
      self.amount = (amount_local.to_d / exchange_rate).round(0)
    end
  end
end
