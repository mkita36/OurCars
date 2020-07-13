class AddDetails4ToCars < ActiveRecord::Migration[6.0]
  def change
    add_column :cars, :purchase_date, :date
  end
end
