class ChangeDataNumberToCars < ActiveRecord::Migration[6.0]
  def change
    change_column :cars, :number, :string
  end
end
