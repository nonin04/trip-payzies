class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  has_many :expenses, dependent: :destroy
  has_many :participants, dependent: :destroy
  accepts_nested_attributes_for :participants, reject_if: :all_blank, limit: 10

  enum settlement_status: { unsettled: 0, settled: 1 }

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 25, message: "25字以内で入力してください" }
  validates :settlement_status, presence: true

  validate :must_have_participant_at_least_one

  before_validation :set_default_status
  before_create :generate_share_token
  
  
  def reset_settlement_status
    self.unsettled! if self.settled?
  end

  private

  def set_default_status
    self.settlement_status ||= :unsettled
  end

  def must_have_participant_at_least_one
    if participants.reject(&:marked_for_destruction?).empty?
      errors.add(:participants, "参加者を一人以上設定していください")
    end
  end

  def generate_share_token
    self.share_token ||= SecureRandom.urlsafe_base64(10)
  end
  
end
