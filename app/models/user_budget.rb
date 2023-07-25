# == Schema Information
#
# Table name: user_budgets
#
#  id                 :integer          not null, primary key
#  first_day_of_month :date
#  last_day_of_month  :date
#  total_expenses     :float
#  total_income       :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#
class UserBudget < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })

end
