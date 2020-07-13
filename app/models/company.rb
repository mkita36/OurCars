class Company < ApplicationRecord
  has_many :managers, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :cars, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
