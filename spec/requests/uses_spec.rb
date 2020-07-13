require 'rails_helper'

RSpec.describe 'Uses', type: :request do
  describe '管理ユーザーとして利用情報を登録する' do
    before do
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
      sign_in @manager
      @car = FactoryBot.create(:car, company: @company)
      @user = FactoryBot.create(:user, company: @company)
    end
    it '利用情報一覧画面にアクセスすること' do
      get company_manager_car_uses_path(@company, @car)
      expect(response).to have_http_status(200)
    end
    it '利用情報新規登録画面にアクセスすること' do
      get new_company_manager_car_use_path(@company, @car)
      expect(response).to have_http_status(200)
    end
    it '登録すること' do
      use = FactoryBot.build(:use, user: @user, car: @car)
      expect {
        post company_manager_car_uses_path(@company, @car), params: {use: use.attributes}
      }.to change(@car.uses, :count).by(1)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      use = FactoryBot.build(:use, use_day: '', user: @user, car: @car)
      post company_manager_car_uses_path(@company, @car), params: {use: use.attributes}
      expect(response).to render_template(:new)
    end
  end

  describe '管理ユーザーとして利用情報を編集・削除する' do
    before do
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
      sign_in @manager
      @car = FactoryBot.create(:car, company: @company)
      @use = FactoryBot.create(:use, car: @car)
    end
    it '利用情報編集画面にアクセスすること' do
      get edit_company_manager_car_use_path(@company, @car, @use)
      expect(response).to have_http_status(200)
    end
    it '編集すること' do
      @use.destination = "中央区役所"
      patch company_manager_car_use_path(@company, @car, @use), params: {use: @use.attributes}
      expect(response).to redirect_to company_manager_car_uses_path(@company, @car)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      @use.destination = ''
      patch company_manager_car_use_path(@company, @car, @use), params: {use: @use.attributes}
      expect(response).to render_template(:edit)
    end
  end

  describe 'ユーザーとして利用情報を登録する' do
    before do
      @company = FactoryBot.create(:company)
      @user = FactoryBot.create(:user, company: @company)
      sign_in @user
      @car = FactoryBot.create(:car, company: @company)
    end
    it '利用情報一覧画面にアクセスすること' do
      get company_car_uses_path(@company, @car)
      expect(response).to have_http_status(200)
    end
    it '利用情報新規登録画面にアクセスすること' do
      get new_company_car_use_path(@company, @car)
      expect(response).to have_http_status(200)
    end
    it '登録すること' do
      use = FactoryBot.build(:use, user: @user, car: @car)
      expect {
        post company_car_uses_path(@company, @car), params: {use: use.attributes}
      }.to change(@car.uses, :count).by(1)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      use = FactoryBot.build(:use, use_day: '', user: @user, car: @car)
      post company_car_uses_path(@company, @car), params: {use: use.attributes}
      expect(response).to render_template(:new)
    end
  end

  describe 'ユーザーとして利用情報を編集・削除する' do
    before do
      @company = FactoryBot.create(:company)
      @user = FactoryBot.create(:user, company: @company)
      sign_in @user
      @car = FactoryBot.create(:car, company: @company)
      @use = FactoryBot.create(:use, car: @car)
    end
    it '利用情報編集画面にアクセスすること' do
      get edit_company_car_use_path(@company, @car, @use)
      expect(response).to have_http_status(200)
    end
    it '編集すること' do
      @use.destination = '中央区役所'
      patch company_car_use_path(@company, @car, @use), params: {use: @use.attributes}
      expect(@use.destination).to eq '中央区役所'
    end
    it '編集後、利用情報一覧にリダイレクトされること' do
      @use.destination = '中央区役所'
      patch company_car_use_path(@company, @car, @use), params: {use: @use.attributes}
      expect(response).to redirect_to company_car_uses_path(@company, @car)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      @use.destination = ''
      patch company_car_use_path(@company, @car, @use), params: {use: @use.attributes}
      expect(response).to render_template(:edit)
    end
  end
end