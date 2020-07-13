class AddDetailsToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :end_day, :date
  end
end
