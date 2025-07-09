class Member < ApplicationRecord
  belongs_to :group

  validates :group_id, presence: true
  validates :name, presence: true, length: { maximum: 15, message: "は15字以内で入力してください" }
  validates :name, uniqueness: { scope: :group_id, message: "が既に存在します。" }
end
