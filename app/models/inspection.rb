class Inspection < ApplicationRecord
  belongs_to :car
  validates :limit, presence: true
  validate :start_end_limit_check

  def start_end_limit_check
    if start_day.present? and end_day.present? and limit.present?
      unless start_day <= end_day and end_day < limit
      errors.add(:start_day, ": 日付の前後関係を確認の上、修正してください")
      errors.add(:end_day, ": 日付の前後関係を確認の上、修正してください")
      errors.add(:limit, ": 日付の前後関係を確認の上、修正してください")
      end
    end
  end
end
