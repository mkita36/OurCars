class ChangeDataRefuelingAmountToUses < ActiveRecord::Migration[6.0]
  def change
    change_column :uses, :refueling_amount, :float
  end
end