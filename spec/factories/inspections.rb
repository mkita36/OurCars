FactoryBot.define do
  factory :inspection do
    start_day { '2020-06-01' }
    end_day { '2020-06-01' }
    fee { 90000 }
    inspection_memo { 'マフラーを交換　エンジンコイルを交換'}
    limit { '2022-5-31' }
    association :car
  end
end
