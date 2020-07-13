class ChangeDataMileageToCars < ActiveRecord::Migration[6.0]
  def change
    change_column :cars, :mileage, :float
  end
end
