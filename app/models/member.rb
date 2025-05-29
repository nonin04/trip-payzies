class Member < ApplicationRecord
  belongs_to :group

  validates :group_id, presence: true
  validates :name, presence: true, length: {maximum: 12, message: "は12字以内"}
  validates :name, uniqueness: {scope: :group_id, message: "が既に存在します。"}
  
end
