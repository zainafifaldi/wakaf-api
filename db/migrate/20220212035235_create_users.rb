class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.text :address
      t.string :password_digest
      t.boolean :email_verified, default: false
      t.string :roles_adjustment

      t.timestamps

      t.index :email
    end
  end
end
