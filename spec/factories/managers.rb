FactoryBot.define do
  factory :manager do
    manager_name { '鈴木一郎' }
    sequence(:email) { |n| "manager#{n}@sp.com" }
    password { 'dddddd' }
    password_confirmation { 'dddddd' }
    association :company
  end
end
