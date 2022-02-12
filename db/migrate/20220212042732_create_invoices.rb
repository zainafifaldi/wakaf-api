class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :invoice_number
      t.integer :transaction_id
      t.decimal :amount
      t.string :payment_method
      t.text :payment_detail
      t.integer :state, limit: 1
      t.datetime :due_time
      t.string :payment_evidence_url

      t.timestamps
    end
  end
end
