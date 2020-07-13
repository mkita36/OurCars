FactoryBot.define do
  factory :memo do
    content "タイヤ交換"
    memo_day "2020-06-19"
    association :car
  end
end
