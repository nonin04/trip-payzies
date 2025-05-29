class Group < ApplicationRecord
  belongs_to :user

  has_many :trips, dependent: :nullify
  has_many :members, dependet: :destroy
  

  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 15, message: "は15字以内"}
  
end
