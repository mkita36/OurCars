FactoryBot.define do
  factory :user do
    user_name { '山田二郎' }
    sequence(:email) { |n| "user#{n}@sp.com" }
    password { 'dddddd' }
    password_confirmation { 'dddddd' }
    association :company
  end
end
