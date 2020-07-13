class AddDetailsToInspections < ActiveRecord::Migration[6.0]
  def change
    add_column :inspections, :start_day, :date
    add_column :inspections, :end_day, :date
  end
end
