class AddUniqueCodeToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :unique_code, :decimal, after: :amount
    add_column :invoices, :total_transfer, :decimal, after: :unique_code

    add_index :invoices, [:state, :total_transfer]
  end
end
