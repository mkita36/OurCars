FactoryBot.define do
  factory :car do
    region { '神戸890' }
    sequence(:number) { |n| "あ00#{n}" }
    car_name { 'マーチ' }
    purchase_day { '2019-08-01' }
    borrower { '鈴木一郎' }
    parking { '鈴木家駐車場' }
    tank { '50' }
    oil_frequency { '5000' }
    initial_odometer { '30' }
    initial_mileage { '15' }
    state { '空車' }
    association :company
  end
end
