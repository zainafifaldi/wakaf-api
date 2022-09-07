class AddOtp < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :otp, :string, limit: 4
    add_column :users, :phone_number_verified, :boolean, default: false

    add_index :users, :phone_number
  end
end
