class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  has_many :expenses, dependent: :destroy
  has_many :participants, dependent: :destroy
  accepts_nested_attributes_for :participants

  enum settlement_status: {unsettled: 0, settled: 1}

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 20, message: "20字以内"}
  validates :settlement_status, presence: true

  before_validation :set_default_status

  private

  def set_default_status
    self.settlement_status ||= :unsettled
  end
end
