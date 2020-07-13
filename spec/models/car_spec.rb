require 'rails_helper'

RSpec.describe Car, type: :model do
  
  it '車名、平仮名・指定番号、地域名・分類番号、購入日、管理者、タンク容量、オイル交換頻度、初期メーター、初期燃費、初期状態があれば有効であること' do
    expect(FactoryBot.build(:car)).to be_valid
  end

  # 平仮名・指定番号がなければ無効な状態であること
  it { is_expected.to validate_presence_of :region}

  # 地域名・分類番号がなければ無効な状態であること
  it { is_expected.to validate_presence_of :number}

  # 車名がなければ無効な状態であること
  it { is_expected.to validate_presence_of :car_name}

  # 購入日がなければ無効な状態であること
  it { is_expected.to validate_presence_of :purchase_day}

  # 管理者がなければ無効な状態であること
  it { is_expected.to validate_presence_of :borrower}

  # 保管場所(車庫証明)がなければ無効な状態であること
  it { is_expected.to validate_presence_of :parking}

  # タンク容量がなければ無効な状態であること
  it { is_expected.to validate_presence_of :tank}

  # オイル交換頻度がなければ無効な状態であること
  it { is_expected.to validate_presence_of :oil_frequency}

  # 初期メーターがなければ無効な状態であること
  it { is_expected.to validate_presence_of :initial_odometer}

  # 初期燃費がなければ無効な状態であること
  it { is_expected.to validate_presence_of :initial_mileage}

  # 初期状態がなければ無効な状態であること
  it { is_expected.to validate_presence_of :state}

  it '「平仮名・指定番号」と「地域名・分類番号」の組み合わせが重複していたら無効な状態であること' do
    @company = FactoryBot.create(:company)
    car1 = FactoryBot.create(:car, number: 'あ0000', company: @company)
    car2 = FactoryBot.build(:car, number: 'あ0000', company: @company)
    car2.valid?
    expect(car2.errors[:number]).to include('は既に使用されています')
  end
end