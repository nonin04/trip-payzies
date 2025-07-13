class Group < ApplicationRecord
  belongs_to :user

  has_many :trips, dependent: :nullify
  has_many :members, dependent: :destroy

  has_one_attached :icon

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 25, message: "は25字以内で入力してください" }
end
