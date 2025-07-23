class Currency < ApplicationRecord
  has_many :exchange_rate
  has_many :trips, dependent: :nullify

  validates :code, presence: true
  validates :ja_name, presence: true
  validates :ja_name, presence: true
  validates :symbol, presence: true
  validates :decimal_position, presence: true


  def display_name
    "#{code}: #{ja_name}"
  end
end
