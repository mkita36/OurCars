class Memo < ApplicationRecord
  belongs_to :car
  validates :content, :memo_day, presence: true
end
