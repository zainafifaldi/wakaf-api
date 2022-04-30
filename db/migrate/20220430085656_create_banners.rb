class CreateBanners < ActiveRecord::Migration[6.0]
  def change
    create_table :banners do |t|
      t.string :image_url
      t.integer :order, limit: 1
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
