class CreateInspections < ActiveRecord::Migration[6.0]
  def change
    create_table :inspections do |t|
      t.date :inspection_day
      t.integer :fee
      t.date :limit
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
