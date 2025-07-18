class Currency < ApplicationRecord
  has_many :exchange_rate
  has_many :trips, dependent: :nullify

  validates :code, presence: true
  validates :ja_name, presence: true
  validates :ja_name, presence: true
end