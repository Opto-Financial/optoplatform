class RemoveExpenseColumns3 < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_budgets, :non_school_expenses
    remove_column :user_budgets, :optional_school_expenses
    remove_column :user_budgets, :required_school_expenses
  end
end
