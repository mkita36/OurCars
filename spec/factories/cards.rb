FactoryBot.define do
  factory :card do
    number { 0 }
    association :user
  end
end
