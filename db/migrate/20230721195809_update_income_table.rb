class UpdateIncomeTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :budget_incomes, :income_category_id, :income_category_id_default
  end
end
