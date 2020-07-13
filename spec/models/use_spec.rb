require 'rails_helper'

RSpec.describe Use, type: :model do
  
  it '利用日、利用後メーター、行先、給油量、洗車、オイル交換、車検があれば有効であること' do
    expect(FactoryBot.build(:use)).to be_valid
  end

  # 利用日がなければ無効な状態であること
  it { is_expected.to validate_presence_of :use_day}

  # 利用後メーターがなければ無効な状態であること
  it { is_expected.to validate_presence_of :odometer}

  # 行先がなければ無効な状態であること
  it { is_expected.to validate_presence_of :destination}

  # 給油量がなければ無効な状態であること
  it { is_expected.to validate_presence_of :refueling_amount}

  # 洗車がなければ無効な状態であること
  it { is_expected.to validate_presence_of :wash}

  # オイル交換がなければ無効な状態であること
  it { is_expected.to validate_presence_of :oil_change}

  # 自主点検がなければ無効な状態であること
  it { is_expected.to validate_presence_of :self_inspection}

  # 車検がなければ無効な状態であること
  it { is_expected.to validate_presence_of :inspection_st}

  it '新規登録時、前の実績の利用日より古い日付だと無効な状態であること' do
    @company = FactoryBot.create(:company)
    @car = FactoryBot.create(:car, company: @company)
    use1 = FactoryBot.create(:use, use_day: '2020-6-15', car: @car)
    use2 = FactoryBot.build(:use, use_day: '2020-6-14', car: @car)
    use2.valid?
    expect(use2.errors[:use_day]).to include(': 最も新しい実績の日付以降の日付を選択してください')
  end

  it '新規登録時、前の実績のメーターより小さい数値だと無効な状態であること' do
    @company = FactoryBot.create(:company)
    @car = FactoryBot.create(:car, company: @company)
    use1 = FactoryBot.create(:use, odometer: 100, car: @car)
    use2 = FactoryBot.build(:use, odometer: 99, car: @car)
    use2.valid?
    expect(use2.errors[:odometer]).to include(': 前回利用時のメーター以上の数値を入力してください')
  end

  it '編集時、ひとつ前の実績の利用日より古い日付だと無効な状態であること' do
    @company = FactoryBot.create(:company)
    @car = FactoryBot.create(:car, company: @company)
    use1 = FactoryBot.create(:use, use_day: '2020-6-15', car: @car)
    use2 = FactoryBot.create(:use, use_day: '2020-6-16', car: @car)
    use2.update(use_day: '2020-6-14')
    expect(use2.errors[:use_day]).to include(': ひとつ前の実績の利用日以降の日付を選択してください')
  end

  it '編集時、ひとつ後の実績の利用日より新しい日付だと無効な状態であること' do
    @company = FactoryBot.create(:company)
    @car = FactoryBot.create(:car, company: @company)
    use1 = FactoryBot.create(:use, use_day: '2020-6-15', car: @car)
    use2 = FactoryBot.create(:use, use_day: '2020-6-16', car: @car)
    use1.update(use_day: '2020-6-17')
    expect(use1.errors[:use_day]).to include(': ひとつ後の実績の利用日以前の日付を選択してください')
  end

  it '編集時、ひとつ前の実績のメーターより小さい数値だと無効な状態であること' do
    @company = FactoryBot.create(:company)
    @car = FactoryBot.create(:car, company: @company)
    use1 = FactoryBot.create(:use, odometer: 100, car: @car)
    use2 = FactoryBot.create(:use, odometer: 110, car: @car)
    use2.update(odometer: 99)
    expect(use2.errors[:odometer]).to include(': ひとつ前の実績のメーター以上の数値を入力してください')
  end

  it '編集時、ひとつ後の実績のメーターより大きい数値だと無効な状態であること' do
    @company = FactoryBot.create(:company)
    @car = FactoryBot.create(:car, company: @company)
    use1 = FactoryBot.create(:use, odometer: 100, car: @car)
    use2 = FactoryBot.create(:use, odometer: 110, car: @car)
    use1.update(odometer: 111)
    expect(use1.errors[:odometer]).to include(': ひとつ後の実績のメーター以下の数値を入力してください')
  end
end