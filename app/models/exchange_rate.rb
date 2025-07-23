class ExchangeRate < ApplicationRecord
  belongs_to :currency

  validates :currency_id, presence: true
  validates :rate_date, presence: true
  validates :rate, presence: true, numericality: { greater_than: 0 }

  validates :currency_id, uniqueness: { scope: :rate_date, message: "と日付の組み合わせは既に存在します" }
end
