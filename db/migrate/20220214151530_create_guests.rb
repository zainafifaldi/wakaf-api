class CreateGuests < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.text :cookie_id, null: false

      t.timestamps
    end
  end
end
