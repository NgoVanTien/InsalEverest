class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :table, foreign_key: true, null: false
      t.integer :state, default: 0
      t.float :total, default: 0.0
      t.string :add_table_ids

      t.timestamps
    end
  end
end
