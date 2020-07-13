require 'rails_helper'

RSpec.describe 'Managers', type: :request do
  describe 'adminがある会社のmanager(管理ユーザー)を登録する' do
    before do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      @company = FactoryBot.create(:company)
    end
    it '管理ユーザー一覧画面にアクセスすること' do
      get admin_company_managers_path(@company)
      expect(response).to have_http_status(200)
    end
    it '管理ユーザー新規登録画面にアクセスすること' do
      get new_admin_company_manager_path(@company)
      expect(response).to have_http_status(200)
    end
    it '登録すること' do
      manager_params = FactoryBot.attributes_for(:manager)
      expect {
        post admin_company_managers_path(@company), params: {manager: manager_params}
      }.to change(@company.managers, :count).by(1)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      manager_params = FactoryBot.attributes_for(:manager, email:'')
      post admin_company_managers_path(@company), params: {manager: manager_params}
      expect(response).to render_template(:new)
    end
  end

  describe 'adminがある会社のmanager(管理ユーザー)情報を編集・削除する' do
    before do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
    end
    it '管理ユーザー情報編集画面にアクセスすること' do
      get edit_admin_company_manager_path(@company, @manager)
      expect(response).to have_http_status(200)
    end
    it '編集すること' do
      @manager.manager_name = "鈴木二郎"
      patch admin_company_manager_path(@company, @manager), params: {manager: @manager.attributes}
      expect(response).to redirect_to admin_company_managers_path(@company)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      manager = FactoryBot.create(:manager, company: @company)
      @manager.email = ''
      patch admin_company_manager_path(@company, @manager), params: {manager: @manager.attributes}
      expect(response).to render_template(:edit)
    end
    it '削除すること' do
      expect {
        delete admin_company_manager_path(@company, @manager)
      }.to change(@company.managers, :count).by(-1)
    end
  end

  describe 'managerがその会社のmanager(管理ユーザー)を登録する' do
    before do
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
      sign_in @manager
    end
    it '管理ユーザー一覧画面にアクセスすること' do
      get company_manager_managers_path(@company)
      expect(response).to have_http_status(200)
    end
    it '管理ユーザー新規登録画面にアクセスすること' do
      get new_company_manager_manager_path(@company)
      expect(response).to have_http_status(200)
    end
    it '登録すること' do
      manager_params = FactoryBot.attributes_for(:manager)
      expect {
        post company_manager_managers_path(@company), params: {manager: manager_params}
      }.to change(@company.managers, :count).by(1)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      manager_params = FactoryBot.attributes_for(:manager, email:'')
      post company_manager_managers_path(@company), params: {manager: manager_params}
      expect(response).to render_template(:new)
    end
  end

  describe 'managerがその会社のmanager(管理ユーザー)情報を編集・削除する' do
    before do
      @company = FactoryBot.create(:company)
      @manager0 = FactoryBot.create(:manager, company: @company)
      sign_in @manager0
      @manager = FactoryBot.create(:manager, company: @company)
    end
    it '管理ユーザー情報編集画面にアクセスすること' do
      get edit_company_manager_manager_path(@company, @manager)
      expect(response).to have_http_status(200)
    end
    it '編集すること' do
      @manager.manager_name = '鈴木二郎'
      patch company_manager_manager_path(@company, @manager), params: {manager: @manager.attributes}
      expect(@manager.manager_name).to eq '鈴木二郎'
    end
    it '編集後、管理ユーザー一覧画面にリダイレクトされること' do
      @manager.manager_name = '鈴木二郎'
      patch company_manager_manager_path(@company, @manager), params: {manager: @manager.attributes}
      expect(response).to redirect_to company_manager_managers_path(@company)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      @manager.email = ''
      patch company_manager_manager_path(@company, @manager), params: {manager: @manager.attributes}
      expect(response).to render_template(:edit)
    end
    it '削除すること' do
      expect {
        delete company_manager_manager_path(@company, @manager)
      }.to change(@company.managers, :count).by(-1)
    end
    it '管理ユーザーが最後の一人の場合、削除できないこと' do
      delete company_manager_manager_path(@company, @manager)
      expect {
        delete company_manager_manager_path(@company, @manager0)
      }.to change(@company.managers, :count).by(0)
    end
  end
end