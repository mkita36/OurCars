require 'rails_helper'

RSpec.describe User, type: :model do
  
  it '名前、メールアドレス、パスワードがあれば有効であること' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 名前がなければ無効な状態であること
  it { is_expected.to validate_presence_of :user_name}

  # メールアドレスがなければ無効な状態であること
  it { is_expected.to validate_presence_of :email}

  it '重複したメールアドレスなら無効な状態であること' do
    company = FactoryBot.create(:company)
    user1 = company.users.create(user_name: '鈴木一郎', email: 'ichiro@sp.com', password: '000000', password_confirmation: '000000')
    user2 = company.users.build(user_name: '山田一郎', email: 'ichiro@sp.com', password: '111111', password_confirmation: '111111')
    user2.valid?
    expect(user2.errors[:email]).to include('は既に使用されています')
  end

  # パスワードが3文字以下だと無効な状態であること
  it { is_expected.to validate_length_of(:password). is_at_least(4).with_message('の文字数が短すぎます')}

  it 'パスワードと確認用パスワードが一致しないと無効な状態であること' do
    user = FactoryBot.build(:user, password: '111111', password_confirmation: '111112')
    user.valid?
    expect(user.errors[:password_confirmation]).to include('はパスワードと一致しません')
  end
end