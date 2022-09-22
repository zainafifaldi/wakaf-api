class AddTimestampsToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :paid_at, :datetime, before: :created_at
    add_column :invoices, :expired_at, :datetime, before: :created_at
    add_column :invoices, :canceled_at, :datetime, before: :created_at
  end
end
