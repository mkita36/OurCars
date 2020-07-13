class RenameStartDayColumnToReservation < ActiveRecord::Migration[6.0]
  def change
    rename_column :reservations, :start_day, :reservation_day
  end
end
