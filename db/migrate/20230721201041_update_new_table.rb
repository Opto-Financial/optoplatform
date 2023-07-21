class UpdateNewTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :transaction_category_defaults, :transaction_categories_defaults
  end
end
