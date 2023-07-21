# == Schema Information
#
# Table name: transactions
#
#  id                            :integer          not null, primary key
#  authorized_datetime           :datetime
#  income_flag                   :boolean
#  iso_currency_code             :text
#  merchant_name                 :string
#  name_plaid                    :text
#  payment_channel               :string
#  pending                       :boolean
#  recurring_end_date            :date
#  recurring_flag                :boolean
#  recurring_frequency           :integer
#  spend_category_id_default     :integer
#  spend_category_id_user        :integer
#  transaction_amount            :float
#  transaction_category_plaid    :text
#  transaction_datetime          :datetime
#  transaction_location          :string
#  transaction_subcategory_plaid :text
#  type_plaid                    :text
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  account_id                    :integer
#  plaid_category_id             :text
#  plaid_transaction_id          :text
#
class Transaction < ApplicationRecord
  # belongs_to(:spend_category, { :required => true, :class_name => "TransactionCategory", :foreign_key => "spend_category_id" })
  belongs_to(:account, { :required => true, :class_name => "Account", :foreign_key => "account_id" })
end
