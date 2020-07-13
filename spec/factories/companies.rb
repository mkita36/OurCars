FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "OurCars#{n}株式会社" }
  end
end
