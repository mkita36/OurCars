class AddDetails2ToInspections < ActiveRecord::Migration[6.0]
  def change
    add_column :inspections, :inspection_memo, :text
  end
end
