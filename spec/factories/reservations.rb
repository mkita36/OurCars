FactoryBot.define do
  factory :reservation do
    reservation_day { '2020-07-15' }
    association :user
    association :car
  end
end
