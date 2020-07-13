class RemoveEndDayFromReservations < ActiveRecord::Migration[6.0]
  def change
    remove_column :reservations, :end_day, :date
  end
end
