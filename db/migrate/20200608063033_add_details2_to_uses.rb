class AddDetails2ToUses < ActiveRecord::Migration[6.0]
  def change
    add_column :uses, :distance, :integer
  end
end
