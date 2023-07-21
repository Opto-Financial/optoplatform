# == Schema Information
#
# Table name: transaction_categories_users
#
#  id                         :integer          not null, primary key
#  spend_category_name        :string
#  spend_sub_category         :string
#  spend_sub_category_details :text
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  user_id                    :integer
#
class TransactionCategoriesUser < ApplicationRecord

  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  has_many(:transactions, { :class_name => "Transaction", :foreign_key => "spend_category_id_user", :dependent => :destroy })
  has_many(:budget_expenses, { :class_name => "BudgetExpense", :foreign_key => "expense_category_id_user", :dependent => :destroy })
  has_many(:budget_incomes, { :class_name => "BudgetIncome", :foreign_key => "income_category_id_user", :dependent => :destroy })

end
