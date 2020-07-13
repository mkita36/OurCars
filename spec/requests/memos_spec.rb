require 'rails_helper'

RSpec.describe 'Memos', type: :request do
  describe 'メンテ情報を登録する' do
    before do
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
      sign_in @manager
      @car = FactoryBot.create(:car, company: @company)
    end
    it 'メンテ情報一覧画面にアクセスすること' do
      get company_manager_car_memos_path(@company, @car)
      expect(response).to have_http_status(200)
    end
    it 'メンテ情報新規登録画面にアクセスすること' do
      get new_company_manager_car_memo_path(@company, @car)
      expect(response).to have_http_status(200)
    end
    it '登録すること' do
      memo_params = FactoryBot.attributes_for(:memo)
      expect {
        post company_manager_car_memos_path(@company, @car), params: {memo: memo_params}
      }.to change(@car.memos, :count).by(1)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      memo_params = FactoryBot.attributes_for(:memo, memo_day: '')
      post company_manager_car_memos_path(@company, @car), params: {memo: memo_params}
      expect(response).to render_template(:new)
    end
  end

  describe 'メンテ情報を編集・削除する' do
    before do
      @company = FactoryBot.create(:company)
      @manager = FactoryBot.create(:manager, company: @company)
      sign_in @manager
      @car = FactoryBot.create(:car, company: @company)
      @memo = FactoryBot.create(:memo, car: @car)
    end
    it 'メンテ情報編集画面にアクセスすること' do
      get edit_company_manager_car_memo_path(@company, @car, @memo)
      expect(response).to have_http_status(200)
    end
    it '編集すること' do
      @memo.content = 'ワイパー交換'
      patch company_manager_car_memo_path(@company, @car, @memo), params: {memo: @memo.attributes}
      expect(@memo.content).to eq 'ワイパー交換'
    end
    it '編集後、メンテ情報一覧画面にリダイレクトすること' do
      @memo.content = 'エンジンコイル交換'
      patch company_manager_car_memo_path(@company, @car, @memo), params: {memo: @memo.attributes}
      expect(response).to redirect_to company_manager_car_memos_path(@company, @car)
    end
    it '登録できなかった場合、フォーム画面が再度表示されること' do
      @memo.memo_day = ''
      patch company_manager_car_memo_path(@company, @car, @memo), params: {memo: @memo.attributes}
      expect(response).to render_template(:edit)
    end
    it '削除すること' do
      expect {
        delete company_manager_car_memo_path(@company, @car, @memo)
      }.to change(@car.memos, :count).by(-1)
    end
  end
end