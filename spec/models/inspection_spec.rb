require 'rails_helper'

RSpec.describe Inspection, type: :model do
  
  it '依頼日、終了日、料金、次回車検満了日があれば有効であること' do
    expect(FactoryBot.build(:inspection)).to be_valid
  end

  # 次回車検満了日がなければ無効な状態であること
  it { is_expected.to validate_presence_of :limit}

  it '終了日が依頼日より前なら無効な状態であること' do
    car = FactoryBot.create(:car, company: FactoryBot.create(:company))
    inspection1 = car.inspections.build(start_day: '2020-06-02', end_day: '2020-06-01', fee: 100000, limit: '2022-06-01')
    inspection1.valid?
    expect(inspection1.errors[:end_day]).to include(': 日付の前後関係を確認の上、修正してください')
  end

  it '次回車検満了日が終了日より前なら無効な状態であること' do
    car = FactoryBot.create(:car, company: FactoryBot.create(:company))
    inspection1 = car.inspections.build(start_day: '2020-06-01', end_day: '2020-06-05', fee: 100000, limit: '2020-06-04')
    inspection1.valid?
    expect(inspection1.errors[:limit]).to include(': 日付の前後関係を確認の上、修正してください')
  end
end