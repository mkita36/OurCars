class AddDetails3ToUses < ActiveRecord::Migration[6.0]
  def change
    add_column :uses, :self_inspection, :string
  end
end
