class NewColIncomeTable < ActiveRecord::Migration[6.0]
  def change
    add_column :budget_incomes, :income_category_id_user, :integer
  end
end
