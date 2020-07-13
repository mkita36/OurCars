class CreateUses < ActiveRecord::Migration[6.0]
  def change
    create_table :uses do |t|
      t.date :use_day
      t.integer :odometer
      t.string :destination
      t.integer :refueling_amount
      t.string :wash
      t.string :oil_change
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
