class RenameDayColumnToReservations < ActiveRecord::Migration[6.0]
  def change
    rename_column :reservations, :day, :start_day
  end
end
