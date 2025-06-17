class User < ApplicationRecord
  has_many :trips, dependent: :destroy
  has_many :groups, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 15, message: "は15字以内" }
end
