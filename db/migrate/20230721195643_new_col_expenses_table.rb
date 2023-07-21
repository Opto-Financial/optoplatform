class NewColExpensesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :budget_expenses, :expense_category_id_user, :integer
  end
end
