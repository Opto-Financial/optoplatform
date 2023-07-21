class CreateTransactionCategoryDefaults < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_category_defaults do |t|
      t.string :spend_category_name
      t.string :spend_sub_category
      t.text :spend_sub_category_details

      t.timestamps
    end
  end
end
