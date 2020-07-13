class AddDetails5ToCars < ActiveRecord::Migration[6.0]
  def change
    add_column :cars, :region, :string
  end
end
