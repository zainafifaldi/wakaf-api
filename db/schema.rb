# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_14_151530) do

  create_table "carts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
    t.string "reference"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_carts_on_product_id"
    t.index ["reference", "user_id"], name: "index_carts_on_reference_and_user_id"
  end

  create_table "guests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "cookie_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "invoice_number"
    t.integer "transaction_id"
    t.integer "user_id"
    t.decimal "amount", precision: 10
    t.string "payment_method"
    t.text "payment_detail"
    t.integer "state", limit: 1
    t.datetime "expire_time"
    t.string "payment_evidence_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_number"], name: "index_invoices_on_invoice_number"
    t.index ["transaction_id"], name: "index_invoices_on_transaction_id"
    t.index ["user_id", "state"], name: "index_invoices_on_user_id_and_state"
  end

  create_table "product_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "product_id"
    t.string "image_url"
    t.integer "order", limit: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 10
    t.text "description"
    t.integer "stock"
    t.boolean "active", default: true
    t.integer "sold_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["active"], name: "index_products_on_active"
  end

  create_table "transaction_products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "transaction_id"
    t.integer "product_id"
    t.string "name"
    t.decimal "price", precision: 10
    t.integer "quantity"
    t.integer "state", limit: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id", "state"], name: "index_transaction_products_on_product_id_and_state"
    t.index ["transaction_id"], name: "index_transaction_products_on_transaction_id"
  end

  create_table "transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "transaction_number"
    t.integer "user_id"
    t.string "donor_name"
    t.string "donor_phone_number"
    t.string "donor_email"
    t.integer "state", limit: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["transaction_number"], name: "index_transactions_on_transaction_number"
    t.index ["user_id", "state"], name: "index_transactions_on_user_id_and_state"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.text "address"
    t.string "password_digest"
    t.boolean "email_verified", default: false
    t.string "roles_adjustment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
  end

end
