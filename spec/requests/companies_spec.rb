require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  describe '会社登録' do
    before do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
    end
    it '会社一覧画面にアクセスすること' do
      get admin_companies_path
      expect(response).to have_http_status(200)
    end
    it '会社新規登録画面にアクセスすること' do
      get new_admin_company_path
      expect(response).to have_http_status(200)
    end
    it '登録すること' do
      company_params = FactoryBot.attributes_for(:company)
      expect {
        post admin_companies_path, params: {company: company_params}
      }.to change(Company, :count).by(1)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      company = FactoryBot.create(:company, name: 'OurCars株式会社')
      company_params = FactoryBot.attributes_for(:company, name: 'OurCars株式会社')
      post admin_companies_path, params: {company: company_params}
      expect(response).to render_template(:new)
    end
  end

  describe '会社情報編集' do
    before do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      @company = FactoryBot.create(:company)
    end
    it '会社情報編集画面にアクセスすること' do
      get edit_admin_company_path(@company)
      expect(response).to have_http_status(200)
    end
    it '編集すること' do
      @company.name = 'OurCaaaars株式会社'
      patch admin_company_path(@company), params: {company: @company.attributes}
      expect(@company.name).to eq 'OurCaaaars株式会社'
    end
    it '編集後、会社一覧画面にリダイレクトすること' do
      @company.name = 'OurCaaaars株式会社'
      patch admin_company_path(@company), params: {company: @company.attributes}
      expect(response).to redirect_to admin_companies_path
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      @company.name = ''
      patch admin_company_path(@company), params: {company: @company.attributes}
      expect(response).to render_template(:edit)
    end
    it '削除すること' do
      expect {
        delete admin_company_path(@company)
      }.to change(Company, :count).by(-1)
    end
  end
end
