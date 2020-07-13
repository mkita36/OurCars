class CreateMemos < ActiveRecord::Migration[6.0]
  def change
    create_table :memos do |t|
      t.text :content
      t.date :memo_day
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
