class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_number
      t.integer :user_id
      t.string :donor_name
      t.string :donor_phone_number
      t.string :donor_email
      t.integer :state, limit: 1

      t.timestamps
    end
  end
end
