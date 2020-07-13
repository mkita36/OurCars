class RenamePurchaseDateColumnToCars < ActiveRecord::Migration[6.0]
  def change
    rename_column :cars, :purchase_date, :purchase_day
  end
end
