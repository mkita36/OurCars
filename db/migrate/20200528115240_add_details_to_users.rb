class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :card, :integer
  end
end