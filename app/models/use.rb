class Use < ApplicationRecord
  belongs_to :user
  belongs_to :car
  validates :use_day, :odometer, :destination, :refueling_amount, :wash, :oil_change, :self_inspection, :inspection_st, presence: true
  validate :newer_than_previous, on: :create
  validate :larger_than_previous, on: :create
  validate :newer_than_previous_and_older_than_following, on: :update
  validate :larger_than_previous_and_smaller_than_following, on: :update
  
  def newer_than_previous
    if use_day.present? and Use.where(car_id: car_id).where('use_day > ?', use_day).present?
      errors.add(:use_day, ": 最も新しい実績の日付以降の日付を選択してください")
    end
  end
  
  def larger_than_previous
    if odometer.present? and Use.where(car_id: car_id).present?
      if Use.where(car_id: car.id).order(:id).last.odometer > odometer
        errors.add(:odometer, ": 前回利用時のメーター以上の数値を入力してください")
      end
    end
  end

  def newer_than_previous_and_older_than_following
    if use_day.present? and Use.where(car_id: car_id).where('id < ?', id).present?
      if Use.where(car_id: car.id).where('id < ?', id).order(:id).last.use_day > use_day
        errors.add(:use_day, ": ひとつ前の実績の利用日以降の日付を選択してください")
      end
    end
    if use_day.present? and Use.where(car_id: car_id).where('id > ?', id).present?
      if Use.where(car_id: car.id).where('id > ?', id).order(:id).first.use_day < use_day
        errors.add(:use_day, ": ひとつ後の実績の利用日以前の日付を選択してください")
      end
    end
  end

  def larger_than_previous_and_smaller_than_following
    if odometer.present? and Use.where(car_id: car_id).where('id < ?', id).present?
      if Use.where(car_id: car.id).where('id < ?', id).order(:id).last.odometer > odometer
        errors.add(:odometer, ": ひとつ前の実績のメーター以上の数値を入力してください")
      end
    end
    if odometer.present? and Use.where(car_id: car_id).where('id > ?', id).present?
      if Use.where(car_id: car.id).where('id > ?', id).order(:id).first.odometer < odometer
        errors.add(:odometer, ": ひとつ後の実績のメーター以下の数値を入力してください")
      end
    end
  end
end