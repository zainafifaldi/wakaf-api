class CreateProductImages < ActiveRecord::Migration[6.0]
  def change
    create_table :product_images do |t|
      t.integer :product_id
      t.string :image_url
      t.integer :order, limit: 1

      t.timestamps

      t.index :product_id
    end
  end
end
