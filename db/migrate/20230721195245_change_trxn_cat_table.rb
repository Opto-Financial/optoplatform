class ChangeTrxnCatTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :transaction_categories, :transaction_categories_users
  end
end
