require 'rails_helper'

RSpec.describe 'Status', type: :request do
  describe 'ユーザーとして車両に乗車し、利用実績を登録する' do
    before do
      @company = FactoryBot.create(:company)
      @user = FactoryBot.create(:user, company: @company)
      sign_in @user
      @car = FactoryBot.create(:car, company: @company)
    end
    it '車両一覧画面にアクセスすること' do
      get company_status_index_path(@company)
      expect(response).to have_http_status(200)
    end
  end
end