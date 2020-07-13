require 'rails_helper'

RSpec.describe Reservation, type: :model do
  
  it '予約日があれば有効であること' do
    expect(FactoryBot.build(:reservation)).to be_valid
  end

  # 予約日がなければ無効な状態であること
  it { is_expected.to validate_presence_of :reservation_day}

  it 'その日に、その車を別の人が既に予約していると無効な状態であること' do
    @company = FactoryBot.create(:company)
    @car = FactoryBot.create(:car, company: @company)
    user1 = FactoryBot.create(:user, company: @company)
    user2 = FactoryBot.create(:user, company: @company)
    reservation1 = user1.reservations.create(reservation_day: '2020-06-10', car: @car)
    reservation2 = user2.reservations.build(reservation_day: '2020-06-10', car: @car)
    reservation2.valid?
    expect(reservation2.errors[:reservation_day]).to include('は既に使用されています')
  end

  it 'その日に、そのユーザーが別の車を既に予約していると無効な状態であること' do
    @company = FactoryBot.create(:company)
    @user = FactoryBot.create(:user, company: @company)
    car1 = FactoryBot.create(:car, company: @company)
    car2 = FactoryBot.create(:car, car_name: 'アクア', region: '大阪890', company: @company)
    reservation1 = car1.reservations.create(reservation_day: '2020-06-10', user: @user)
    reservation2 = car2.reservations.build(reservation_day: '2020-06-10', user: @user)
    reservation2.valid?
    expect(reservation2.errors[:reservation_day]).to include('は既に使用されています')
  end
end