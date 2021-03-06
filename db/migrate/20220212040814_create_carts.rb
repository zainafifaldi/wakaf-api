class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.integer :product_id
      t.integer :user_id
      t.string :reference # User | Session
      t.integer :quantity

      t.timestamps

      t.index [:reference, :user_id]
      t.index :product_id
    end
  end
end
