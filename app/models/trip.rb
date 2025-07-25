class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  belongs_to :currency

  has_many :expenses, dependent: :destroy
  has_many :participants, dependent: :destroy
  accepts_nested_attributes_for :participants, reject_if: :all_blank

  enum settlement_status: { unsettled: 0, settled: 1 }

  validates :user_id, presence: true
  validates :currency_id, presence: true
  validates :title, presence: true, length: { maximum: 25, message: "は25字以内で入力してください" }
  validates :settlement_status, presence: true

  validate :must_have_participant_at_least_one
  validate :participants_within_limit

  before_validation :set_default_currency
  before_validation :set_default_status

  before_create :generate_share_token

  def reset_settlement_status
    self.unsettled! if self.settled?
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "departure_date", "group_id", "id", "settlement_status", "title", "updated_at" ]
  end

  private

  def set_default_status
    self.settlement_status ||= :unsettled
  end

  def set_default_currency
    self.currency_id ||= Currency.find_by!(code: "JPY").id
  end

  def must_have_participant_at_least_one
    if participants.reject(&:marked_for_destruction?).empty?
      errors.add(:participants, "参加者を一人以上設定していください")
    end
  end

  def generate_share_token
    self.share_token ||= SecureRandom.urlsafe_base64(15)
  end

  def participants_within_limit
    count = participants.reject(&:marked_for_destruction?).size
    if count > 10
      errors.add(:participants, "は10人までしか追加できません")
    end
  end
end
