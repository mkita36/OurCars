class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car
  validates :reservation_day, presence: true
  validates :reservation_day, uniqueness: {scope: :car_id}
  validates :reservation_day, uniqueness: {scope: :user_id}
end
