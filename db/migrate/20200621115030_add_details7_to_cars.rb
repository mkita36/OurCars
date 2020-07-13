class AddDetails7ToCars < ActiveRecord::Migration[6.0]
  def change
    add_column :cars, :initial_mileage, :float
  end
end
