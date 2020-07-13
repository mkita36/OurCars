require 'rails_helper'

RSpec.describe 'Cards', type: :request do
  describe 'card(プリペイドカード)を登録する' do
    before do
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
      sign_in @manager
      @user = FactoryBot.create(:user, company: @company)
      @card = FactoryBot.create(:card, user: @user)
    end
    it 'プリペイドカード情報編集画面にアクセスすること' do
      get edit_company_manager_user_card_path(@company, @user, @card)
      expect(response).to have_http_status(200)
    end
    it '編集すること' do
      @card.number = 1
      patch company_manager_user_card_path(@company, @user, @card), params: {card: @card.attributes}
      expect(@user.card.number).to eq 1
    end
    it '編集後、ユーザー一覧画面にリダイレクトすること' do
      @card.number = 1
      patch company_manager_user_card_path(@company, @user, @card), params: {card: @card.attributes}
      expect(response).to redirect_to company_manager_users_path(@company)
    end
  end
end
