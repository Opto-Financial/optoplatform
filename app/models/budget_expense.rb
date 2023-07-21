# == Schema Information
#
# Table name: budget_expenses
#
#  id                          :integer          not null, primary key
#  expense_amount              :float
#  expense_category_id_default :integer
#  expense_category_id_user    :integer
#  expense_name                :string
#  first_recurrence_date       :date
#  recurring_frequency         :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  user_id                     :integer
#
class BudgetExpense < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  belongs_to(:expense_category, { :required => true, :class_name => "TransactionCategoriesDefault", :foreign_key => "expense_category_id_default" })

  scope :by_month, -> (year, month_name = '') {
      month              = Date::MONTHNAMES.index(month_name.capitalize)
      first_day_of_month = Date.new(year, month, 1)
      last_day_of_month  = Date.new(year, month, -1) # Gives you the last day of month
      where("first_recurrence_date between ? and ?", first_day_of_month, last_day_of_month)
    }

end
