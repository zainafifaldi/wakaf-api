class CreateTransactionProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_products do |t|
      t.integer :transaction_id
      t.integer :product_id
      t.string :name
      t.decimal :price
      t.integer :quantity
      t.integer :state, limit: 1

      t.timestamps

      t.index :transaction_id
      t.index [:product_id, :state]
    end
  end
end
