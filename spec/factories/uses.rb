FactoryBot.define do
  factory :use do
    use_day { '2020-06-15' }
    odometer { '100' }
    destination { '西宮市役所' }
    refueling_amount { 40 }
    wash { '無' }
    oil_change { '無' }
    self_inspection { '無' }
    inspection_st { '無' }
    association :user
    association :car
  end
end