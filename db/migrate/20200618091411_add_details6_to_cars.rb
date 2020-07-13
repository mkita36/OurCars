class AddDetails6ToCars < ActiveRecord::Migration[6.0]
  def change
    add_column :cars, :parking, :string
  end
end
