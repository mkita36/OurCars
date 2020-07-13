class AddDetailsToUses < ActiveRecord::Migration[6.0]
  def change
    add_column :uses, :inspection_st, :string
  end
end
