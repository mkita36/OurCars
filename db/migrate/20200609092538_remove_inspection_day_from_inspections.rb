class RemoveInspectionDayFromInspections < ActiveRecord::Migration[6.0]
  def change
    remove_column :inspections, :inspection_day, :date
  end
end
