require 'rails_helper'

RSpec.describe 'Inspections', type: :request do
  describe '車検を登録する' do
    before do
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
      @car = FactoryBot.create(:car, company: @company)
      sign_in @manager
    end
    it '車検一覧画面にアクセスすること' do
      get company_manager_car_inspections_path(@company, @car)
      expect(response).to have_http_status(200)
    end
    it '車検新規登録画面にアクセスすること' do
      get new_company_manager_car_inspection_path(@company, @car)
      expect(response).to have_http_status(200)
    end
    it '登録すること' do
      inspection_params = FactoryBot.attributes_for(:inspection)
      expect {
        post company_manager_car_inspections_path(@company, @car), params: {inspection: inspection_params}
      }.to change(@car.inspections, :count).by(1)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      inspection_params = FactoryBot.attributes_for(:inspection, limit: '')
      post company_manager_car_inspections_path(@company, @car), params: {inspection: inspection_params}
      expect(response).to render_template(:new)
    end
  end

  describe '車検情報を編集・削除する' do
    before do
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
      sign_in @manager
      @car = FactoryBot.create(:car, company: @company)
      @inspection = FactoryBot.create(:inspection, car: @car)
    end
    it '車両情報編集画面にアクセスすること' do
      get edit_company_manager_car_inspection_path(@company, @car, @inspection)
      expect(response).to have_http_status(200)
    end
    it '編集すること' do
      @inspection.fee = 100000
      patch company_manager_car_inspection_path(@company, @car, @inspection), params: {inspection: @inspection.attributes}
      expect(@inspection.fee).to eq 100000
    end
    it '編集後、車検一覧画面にリダイレクトすること' do
      @inspection.fee = 100000
      patch company_manager_car_inspection_path(@company, @car, @inspection), params: {inspection: @inspection.attributes}
      expect(response).to redirect_to company_manager_car_inspections_path(@company, @car)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      @inspection.limit = ''
      patch company_manager_car_inspection_path(@company, @car, @inspection), params: {inspection: @inspection.attributes}
      expect(response).to render_template(:edit)
    end
    it '削除すること' do
      expect {
        delete company_manager_car_inspection_path(@company, @car, @inspection)
      }.to change(@car.inspections, :count).by(-1)
    end
  end
end
