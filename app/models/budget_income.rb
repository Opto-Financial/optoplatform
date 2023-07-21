# == Schema Information
#
# Table name: budget_incomes
#
#  id                         :integer          not null, primary key
#  first_recurrence_date      :date
#  income_amount              :float
#  income_category_id_default :integer
#  income_category_id_user    :integer
#  income_name                :string
#  recurring_frequency        :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  user_id                    :integer
#
class BudgetIncome < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  belongs_to(:income_category, { :required => true, :class_name => "TransactionCategoriesDefault", :foreign_key => "income_category_id_default" })

  scope :by_month, -> (year, month_name = '') {
      month              = Date::MONTHNAMES.index(month_name.capitalize)
      first_day_of_month = Date.new(year, month, 1)
      last_day_of_month  = Date.new(year, month, -1) # Gives you the last day of month
      where("first_recurrence_date between ? and ?", first_day_of_month, last_day_of_month)
    }

end
