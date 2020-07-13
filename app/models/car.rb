class Car < ApplicationRecord
  belongs_to :company
  has_many :uses, dependent: :destroy
  has_many :inspections, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :memos, dependent: :destroy
  validates :car_name, :region, :number, :purchase_day, :borrower, :parking, :tank, :oil_frequency, :initial_odometer, :initial_mileage, :state, presence: true
  validates :number, uniqueness: {scope: :region}
end
