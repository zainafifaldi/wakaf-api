class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.integer :stock
      t.boolean :active, default: true
      t.integer :sold_count, default: 0

      t.timestamps
    end
  end
end
