# == Schema Information
#
# Table name: current_loans
#
#  id                            :integer          not null, primary key
#  amount_borrowed               :float
#  amount_remaining              :float
#  apr                           :float
#  first_payment_date            :date
#  lender_name                   :string
#  loan_start_date               :date
#  loan_total_cost               :float
#  monthly_payments_after_school :float
#  monthly_payments_in_school    :float
#  repayment_period              :integer
#  total_loan_amount             :float
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  user_id                       :integer
#
class OtherLoan < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
end
