class RemoveCardFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :card, :integer
  end
end
