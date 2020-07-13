require 'rails_helper'

RSpec.describe Admin, type: :model do
  
  it 'メールアドレス、パスワードがあれば有効であること' do
    expect(FactoryBot.build(:admin)).to be_valid
  end

  # メールアドレスがなければ無効な状態であること
  it { is_expected.to validate_presence_of :email}

  it '重複したメールアドレスなら無効な状態であること' do
    admin1 = FactoryBot.create(:admin, email: 'admin@sp.com')
    admin2 = FactoryBot.build(:admin, email: 'admin@sp.com')
    admin2.valid?
    expect(admin2.errors[:email]).to include('は既に使用されています')
  end

  # パスワードが5文字以下だと無効な状態であること
  it { is_expected.to validate_length_of(:password). is_at_least(6).with_message('の文字数が短すぎます')}

  it 'パスワードと確認用パスワードが一致しないと無効な状態であること' do
    admin = FactoryBot.build(:admin, password: '111111', password_confirmation: '111112')
    admin.valid?
    expect(admin.errors[:password_confirmation]).to include('はパスワードと一致しません')
  end
end