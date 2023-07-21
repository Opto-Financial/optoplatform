class UpdateExpensesTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :budget_expenses, :expense_category_id, :expense_category_id_default
  end
end
