class Manager < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :validatable,
         :rememberable, password_length: 4..128
  belongs_to :company
  validates :manager_name, presence: true
end