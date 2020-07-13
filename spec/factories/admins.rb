FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin#{n}@sp.com" }
    password { 'dddddd' }
    password_confirmation { 'dddddd' }    
  end
end