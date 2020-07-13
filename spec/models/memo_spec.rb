require 'rails_helper'

RSpec.describe Memo, type: :model do
  it 'メンテナンス日、内容があれば有効であること' do
    expect(FactoryBot.build(:memo)).to be_valid
end

  # メンテナンス日がなければ無効な状態であること
  it { is_expected.to validate_presence_of :memo_day}

  # 内容がなければ無効な状態であること
  it { is_expected.to validate_presence_of :content}
end