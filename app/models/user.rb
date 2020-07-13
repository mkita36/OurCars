class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :validatable,
         :rememberable, password_length: 4..128
  belongs_to :company
  has_many :uses, dependent: :restrict_with_error
  has_many :reservations, dependent: :destroy
  has_one :card, dependent: :destroy
  validates :user_name, presence: true
end