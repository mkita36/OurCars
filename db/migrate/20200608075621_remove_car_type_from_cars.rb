class RemoveCarTypeFromCars < ActiveRecord::Migration[6.0]
  def change
    remove_column :cars, :car_type, :string
  end
end
