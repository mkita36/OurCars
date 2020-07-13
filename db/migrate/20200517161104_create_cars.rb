class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :type
      t.string :car_name
      t.integer :number
      t.string :lease
      t.integer :tank
      t.integer :oil_frequency
      t.integer :initial_odometer
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
