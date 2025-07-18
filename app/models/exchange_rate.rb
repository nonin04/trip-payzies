class ExchangeRate < ApplicationRecord
  belongs_to :currency

  validates :currecy_id, presence: true
  validates :user_id, presence: true
  
end