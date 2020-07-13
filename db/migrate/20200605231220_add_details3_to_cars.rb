class AddDetails3ToCars < ActiveRecord::Migration[6.0]
  def change
    add_column :cars, :borrower, :string
  end
end
