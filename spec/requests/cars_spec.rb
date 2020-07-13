require 'rails_helper'

RSpec.describe 'Cars', type: :request do
  describe 'carを登録する' do
    before do
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
      sign_in @manager
    end
    it '車両一覧画面にアクセスすること' do
      get company_manager_cars_path(@company)
      expect(response).to have_http_status(200)
    end
    it '車両新規登録画面にアクセスすること' do
      get new_company_manager_car_path(@company)
      expect(response).to have_http_status(200)
    end
    it '登録すること' do
      car_params = FactoryBot.attributes_for(:car)
      expect {
        post company_manager_cars_path(@company), params: {car: car_params}
      }.to change(@company.cars, :count).by(1)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      car_params = FactoryBot.attributes_for(:car, car_name: '')
      post company_manager_cars_path(@company), params: {car: car_params}
      expect(response).to render_template(:new)
    end
  end

  describe 'car情報を編集・削除する' do
    before do
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
      sign_in @manager
      @car = FactoryBot.create(:car, company: @company)
    end
    it '車両詳細情報画面にアクセスすること' do
      get company_manager_car_path(@company, @car)
      expect(response).to have_http_status(200)
    end
    it '車両情報編集画面にアクセスすること' do
      get edit_company_manager_car_path(@company, @car)
      expect(response).to have_http_status(200)
    end
    it '編集すること' do
      @car.car_name = "アクア"
      patch company_manager_car_path(@company, @car), params: {car: @car.attributes}
      expect(@car.car_name).to eq 'アクア'
    end
    it '編集後、車両詳細情報画面にリダイレクトすること' do
      @car.car_name = "アクア"
      patch company_manager_car_path(@company, @car), params: {car: @car.attributes}
      expect(response).to redirect_to company_manager_car_path(@company)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      @car.car_name = ''
      patch company_manager_car_path(@company, @car), params: {car: @car.attributes}
      expect(response).to render_template(:edit)
    end
    it '削除すること' do
      expect {
        delete company_manager_car_path(@company, @car)
      }.to change(@company.cars, :count).by(-1)
    end
  end
end