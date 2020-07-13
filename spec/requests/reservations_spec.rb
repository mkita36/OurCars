require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  describe '予約を登録する' do
    before do
      @company = FactoryBot.create(:company)
      @user = FactoryBot.create(:user, company: @company)
      @car = FactoryBot.create(:car, company: @company)
      sign_in @user
    end
    it '予約一覧画面にアクセスすること' do
      get company_car_reservations_path(@company, @car)
      expect(response).to have_http_status(200)
    end
    it '車検新規登録画面にアクセスすること' do
      get new_company_car_reservation_path(@company, @car)
      expect(response).to have_http_status(200)
    end
    it '登録すること' do
      reservation = FactoryBot.build(:reservation, user:@user, car:@car)
      expect {
        post company_car_reservations_path(@company, @car), params: {reservation: reservation.attributes}
      }.to change(@car.reservations, :count).by(1)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      reservation_params = FactoryBot.attributes_for(:reservation, reservation_day: '')
      post company_car_reservations_path(@company, @car), params: {reservation: reservation_params}
      expect(response).to render_template(:new)
    end
  end

  describe '予約を削除する' do
    before do
      @company = FactoryBot.create(:company)
      @user = FactoryBot.create(:user, company: @company)
      sign_in @user
      @car = FactoryBot.create(:car, company: @company)
      @reservation = FactoryBot.create(:reservation, car: @car)
    end
    it '削除すること' do
      expect {
        delete company_car_reservation_path(@company, @car, @reservation)
      }.to change(@car.reservations, :count).by(-1)
    end
  end
end
