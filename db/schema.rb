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

ActiveRecord::Schema.define(version: 2022_12_14_055946) do

  create_table "accounts", force: :cascade do |t|
    t.string "account_type"
    t.integer "user_id"
    t.integer "item_id"
    t.text "name_plaid"
    t.text "plaid_account_id"
    t.text "mask_plaid"
    t.text "official_name_plaid"
    t.float "current_balance_plaid"
    t.float "available_balance_plaid"
    t.text "iso_currency_code_plaid"
    t.text "type_plaid"
    t.text "subtype_plaid"
    t.integer "credit_cards_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.float "account_balance"
    t.boolean "savings_account_flag"
    t.integer "asset_id"
    t.string "plaid_account_id"
    t.integer "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "budget_expenses", force: :cascade do |t|
    t.string "expense_name"
    t.float "expense_amount"
    t.integer "expense_category_id"
    t.integer "recurring_frequency"
    t.integer "user_id"
    t.date "first_recurrence_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "budget_incomes", force: :cascade do |t|
    t.string "income_name"
    t.float "income_amount"
    t.integer "income_category_id"
    t.date "first_recurrence_date"
    t.integer "recurring_frequency"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cash_flows", force: :cascade do |t|
    t.integer "user_id"
    t.date "first_day_of_week"
    t.date "last_day_of_week"
    t.float "remaining_cash"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.float "apr"
    t.string "card_name"
    t.float "credit_line"
    t.float "current_balance"
    t.float "minimum_payment"
    t.date "payment_date"
    t.date "statement_start_date"
    t.string "plaid_account_id"
    t.integer "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "current_loans", force: :cascade do |t|
    t.float "amount_borrowed"
    t.float "amount_remaining"
    t.float "apr"
    t.date "first_payment_date"
    t.string "lender_name"
    t.date "loan_start_date"
    t.float "loan_total_cost"
    t.float "monthly_payments_after_school"
    t.float "monthly_payments_in_school"
    t.integer "repayment_period"
    t.float "total_loan_amount"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "loan_comparisons", force: :cascade do |t|
    t.float "apr"
    t.string "lender_name"
    t.float "loan_total_cost"
    t.float "monthly_payments_after_school"
    t.float "monthly_payments_in_school"
    t.integer "repayment_period"
    t.float "total_loan_amount"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "loan_disbursements", force: :cascade do |t|
    t.integer "loan_id"
    t.float "disbursement_amount"
    t.datetime "disbursement_datetime"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plaid_items", force: :cascade do |t|
    t.integer "user_id"
    t.text "plaid_access_token"
    t.text "plaid_item_id"
    t.text "plaid_institution_id"
    t.text "status"
    t.text "transactions_cursor"
    t.integer "accounts_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "school_event_payments", force: :cascade do |t|
    t.datetime "payment_due_datetime"
    t.float "payment_amount"
    t.integer "school_event_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "school_events", force: :cascade do |t|
    t.string "school"
    t.string "event_name"
    t.date "event_start_date"
    t.string "host"
    t.float "estimated_cost"
    t.date "event_end_date"
    t.integer "user_id"
    t.integer "school_event_payments_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "school_fees", force: :cascade do |t|
    t.string "fee_name"
    t.date "first_fee_date"
    t.string "school"
    t.float "fee_amount"
    t.string "term"
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spend_intentions", force: :cascade do |t|
    t.integer "user_id"
    t.text "spend_intention"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transaction_categories", force: :cascade do |t|
    t.string "spend_category_name"
    t.integer "user_id"
    t.string "spend_sub_category"
    t.text "spend_sub_category_details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.text "name_plaid"
    t.float "transaction_amount"
    t.datetime "transaction_datetime"
    t.integer "recurring_frequency"
    t.date "recurring_end_date"
    t.integer "spend_category_id"
    t.boolean "income_flag"
    t.boolean "recurring_flag"
    t.text "iso_currency_code"
    t.string "merchant_name"
    t.string "payment_channel"
    t.text "transaction_category_plaid"
    t.datetime "authorized_datetime"
    t.string "transaction_location"
    t.text "transaction_subcategory_plaid"
    t.bigint "account_id"
    t.text "plaid_transaction_id"
    t.text "plaid_category_id"
    t.text "type_plaid"
    t.boolean "pending"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_budgets", force: :cascade do |t|
    t.integer "user_id"
    t.date "first_day_of_month"
    t.date "last_day_of_month"
    t.float "non_school_expenses"
    t.float "required_school_expenses"
    t.float "optional_school_expenses"
    t.float "total_expenses"
    t.float "total_income"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.date "graduation_date"
    t.string "school"
    t.boolean "international_student_status"
    t.string "premba_industry"
    t.string "gender"
    t.date "birth_date"
    t.integer "loan_comparisons_count"
    t.integer "spend_intentions_count"
    t.integer "accounts_count"
    t.integer "budget_expenses_count"
    t.integer "budget_incomes_count"
    t.integer "current_loans_count"
    t.integer "transaction_categories_count"
    t.integer "school_events_count"
    t.integer "plaid_items_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_budgets_count"
    t.integer "cash_flows_count"
    t.string "activation_digest"
    t.boolean "activated"
    t.datetime "activated_at"
  end

end
