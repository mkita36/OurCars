require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'managerがその会社のuserを登録する' do
    before do
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
      sign_in @manager
    end
    it '管理ユーザー一覧画面にアクセスすること' do
      get company_manager_users_path(@company)
      expect(response).to have_http_status(200)
    end
    it '管理ユーザー新規登録画面にアクセスすること' do
      get new_company_manager_user_path(@company)
      expect(response).to have_http_status(200)
    end
    it '登録すること' do
      user_params = FactoryBot.attributes_for(:user, company: @company)
      expect {
        post company_manager_users_path(@company), params: {user: user_params}
      }.to change(@company.users, :count).by(1)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      user = FactoryBot.create(:user, email:'a@sp.com', company: @company)
      user_params = FactoryBot.attributes_for(:user, email:'a@sp.com', company: @company)
      post company_manager_users_path(@company), params: {user: user_params}
      expect(response).to render_template(:new)
    end
  end

  describe 'managerがその会社のuser情報を編集・削除する' do
    before do
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
      sign_in @manager
      @user = FactoryBot.create(:user, company: @company)
    end
    it 'ユーザー情報編集画面にアクセスすること' do
      get edit_company_manager_user_path(@company, @user)
      expect(response).to have_http_status(200)
    end
    it '編集すること' do
      @user.user_name = '鈴木二郎'
      patch company_manager_user_path(@company, @user), params: {user: @user.attributes}
      expect(@user.user_name).to eq '鈴木二郎'
    end
    it '編集後、ユーザー一覧画面にリダイレクトされること' do
      @user.user_name = "鈴木二郎"
      patch company_manager_user_path(@company, @user), params: {user: @user.attributes}
      expect(response).to redirect_to company_manager_users_path(@company)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      user = FactoryBot.create(:user, email: 'a@sp.com', company: @company)
      @user.email = "a@sp.com"
      patch company_manager_user_path(@company, @user), params: {user: @user.attributes}
      expect(response).to render_template(:edit)
    end
    it '削除すること' do
      expect {
        delete company_manager_user_path(@company, @user)
      }.to change(@company.users, :count).by(-1)
    end
  end
end
