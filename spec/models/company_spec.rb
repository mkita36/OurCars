require 'rails_helper'

RSpec.describe Company, type: :model do

  it '会社名があれば有効であること' do
    expect(FactoryBot.build(:company)).to be_valid
  end

  # 名前がなければ無効な状態であること
  it { is_expected.to validate_presence_of :name}

  it '重複した会社名なら無効な状態であること' do
    company1 = FactoryBot.create(:company, name: 'aaa株式会社')
    company2 = FactoryBot.build(:company, name: 'aaa株式会社')
    company2.valid?
    expect(company2.errors[:name]).to include('は既に使用されています')
  end

end
