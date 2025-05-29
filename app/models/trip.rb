class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  has_many :expenses, dependent: :destroy
  has_many :participants, dependent: :destroy

  enum settlement_status: {unsettled: 0, settled: 1}

  validates :titile, presence: true, length: {maximum: 20, message: "20字以内"}

end
