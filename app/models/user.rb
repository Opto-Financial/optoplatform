# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  accounts_count               :integer
#  activated                    :boolean
#  activated_at                 :datetime
#  activation_digest            :string
#  birth_date                   :date
#  budget_expenses_count        :integer
#  budget_incomes_count         :integer
#  cash_flows_count             :integer
#  current_loans_count          :integer
#  email                        :string
#  first_name                   :string
#  gender                       :string
#  graduation_date              :date
#  international_student_status :boolean
#  last_name                    :string
#  loan_comparisons_count       :integer
#  password_digest              :string
#  plaid_items_count            :integer
#  premba_industry              :string
#  school                       :string
#  school_events_count          :integer
#  spend_intentions_count       :integer
#  transaction_categories_count :integer
#  user_budgets_count           :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
class User < ApplicationRecord
  attr_accessor :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest

  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:loan_comparisons, { :class_name => "LoanComparison", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:spend_intentions, { :class_name => "SpendIntention", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:accounts, { :class_name => "Account", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:budget_expenses, { :class_name => "BudgetExpense", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:budget_incomes, { :class_name => "BudgetIncome", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:current_loans, { :class_name => "CurrentLoan", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:transaction_categories, { :class_name => "TransactionCategory", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:school_events, { :class_name => "SchoolEvent", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:plaid_items, { :class_name => "PlaidItem", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:user_budgets, { :class_name => "UserBudget", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:cash_flows, { :class_name => "CashFlow", :foreign_key => "user_id", :dependent => :destroy })

  after_create :set_defaults

  def set_defaults

    TransactionCategory.create(:spend_category_name=>'Auto & Transportation',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Bills & Utilities',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Debt Payments',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Dining & Drinking',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Education',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Entertainment',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Fitness & Personal Care',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Gifts and Donations',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Government',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Groceries',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Health & Insurance',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Home',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Pets',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Rent / Mortgage',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Services',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Shopping',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Travel',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Other',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')

    #Below are all of the subcategories for Plaid transactions
    TransactionCategory.create(:spend_category_name=>'Auto & Transportation',:user_id=>self.id,:spend_sub_category=>'Auto Expenses',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Auto & Transportation',:user_id=>self.id,:spend_sub_category=>'Car Loan Payments',:spend_sub_category_details=>'Car Loan Payments')
    TransactionCategory.create(:spend_category_name=>'Auto & Transportation',:user_id=>self.id,:spend_sub_category=>'Gas',:spend_sub_category_details=>'Gas')
    TransactionCategory.create(:spend_category_name=>'Auto & Transportation',:user_id=>self.id,:spend_sub_category=>'Parking',:spend_sub_category_details=>'Parking')
    TransactionCategory.create(:spend_category_name=>'Auto & Transportation',:user_id=>self.id,:spend_sub_category=>'Public Transportation',:spend_sub_category_details=>'Public Transportation')
    TransactionCategory.create(:spend_category_name=>'Auto & Transportation',:user_id=>self.id,:spend_sub_category=>'Taxis and Ride Share',:spend_sub_category_details=>'Taxis and Ride Share')
    TransactionCategory.create(:spend_category_name=>'Auto & Transportation',:user_id=>self.id,:spend_sub_category=>'Tolls',:spend_sub_category_details=>'Tolls')
    TransactionCategory.create(:spend_category_name=>'Bills & Utilities',:user_id=>self.id,:spend_sub_category=>'General',:spend_sub_category_details=>'Misc. Budget Items')
    TransactionCategory.create(:spend_category_name=>'Bills & Utilities',:user_id=>self.id,:spend_sub_category=>'Internet and Cable',:spend_sub_category_details=>'Internet and Cable')
    TransactionCategory.create(:spend_category_name=>'Bills & Utilities',:user_id=>self.id,:spend_sub_category=>'Phone',:spend_sub_category_details=>'Phone')
    TransactionCategory.create(:spend_category_name=>'Bills & Utilities',:user_id=>self.id,:spend_sub_category=>'Utilities',:spend_sub_category_details=>'Utilities')
    TransactionCategory.create(:spend_category_name=>'Debt Payments',:user_id=>self.id,:spend_sub_category=>'Credit Card',:spend_sub_category_details=>'Credit Card')  
    TransactionCategory.create(:spend_category_name=>'Debt Payments',:user_id=>self.id,:spend_sub_category=>'Personal Loans',:spend_sub_category_details=>'Personal Loans')
    TransactionCategory.create(:spend_category_name=>'Debt Payments',:user_id=>self.id,:spend_sub_category=>'Student Loans',:spend_sub_category_details=>'Student Loans')
    TransactionCategory.create(:spend_category_name=>'Debt Payments',:user_id=>self.id,:spend_sub_category=>'Other',:spend_sub_category_details=>'Other')
    TransactionCategory.create(:spend_category_name=>'Dining & Drinking',:user_id=>self.id,:spend_sub_category=>'Alcohol',:spend_sub_category_details=>'Alcohol')
    TransactionCategory.create(:spend_category_name=>'Dining & Drinking',:user_id=>self.id,:spend_sub_category=>'Coffee Shops',:spend_sub_category_details=>'Coffee Shops')
    TransactionCategory.create(:spend_category_name=>'Dining & Drinking',:user_id=>self.id,:spend_sub_category=>'Restaurants & Bars',:spend_sub_category_details=>'Restaurants & Bars')
    TransactionCategory.create(:spend_category_name=>'Dining & Drinking',:user_id=>self.id,:spend_sub_category=>'Other',:spend_sub_category_details=>'Other')
    TransactionCategory.create(:spend_category_name=>'Education',:user_id=>self.id,:spend_sub_category=>'All Education Expenses',:spend_sub_category_details=>'All Education Expenses')
    TransactionCategory.create(:spend_category_name=>'Entertainment',:user_id=>self.id,:spend_sub_category=>'In-person Events',:spend_sub_category_details=>'In-person Events')
    TransactionCategory.create(:spend_category_name=>'Entertainment',:user_id=>self.id,:spend_sub_category=>'Music & Audio',:spend_sub_category_details=>'Music & Audio')
    TransactionCategory.create(:spend_category_name=>'Entertainment',:user_id=>self.id,:spend_sub_category=>'TV & Movies',:spend_sub_category_details=>'TV & Movies')
    TransactionCategory.create(:spend_category_name=>'Entertainment',:user_id=>self.id,:spend_sub_category=>'Video Games',:spend_sub_category_details=>'Video Games')
    TransactionCategory.create(:spend_category_name=>'Entertainment',:user_id=>self.id,:spend_sub_category=>'Other',:spend_sub_category_details=>'Other')
    TransactionCategory.create(:spend_category_name=>'Fitness & Personal Care',:user_id=>self.id,:spend_sub_category=>'Beauty',:spend_sub_category_details=>'Beauty')
    TransactionCategory.create(:spend_category_name=>'Fitness & Personal Care',:user_id=>self.id,:spend_sub_category=>'Fitness',:spend_sub_category_details=>'Fitness')
    TransactionCategory.create(:spend_category_name=>'Fitness & Personal Care',:user_id=>self.id,:spend_sub_category=>'Other',:spend_sub_category_details=>'Other')
    TransactionCategory.create(:spend_category_name=>'Gifts and Donations',:user_id=>self.id,:spend_sub_category=>'Donations',:spend_sub_category_details=>'Donations')
    TransactionCategory.create(:spend_category_name=>'Gifts and Donations',:user_id=>self.id,:spend_sub_category=>'Gifts',:spend_sub_category_details=>'Gifts')
    TransactionCategory.create(:spend_category_name=>'Government',:user_id=>self.id,:spend_sub_category=>'Taxes',:spend_sub_category_details=>'Taxes')
    TransactionCategory.create(:spend_category_name=>'Government',:user_id=>self.id,:spend_sub_category=>'Other',:spend_sub_category_details=>'Other')
    TransactionCategory.create(:spend_category_name=>'Groceries',:user_id=>self.id,:spend_sub_category=>'Convenience Store',:spend_sub_category_details=>'Convenience Store')
    TransactionCategory.create(:spend_category_name=>'Groceries',:user_id=>self.id,:spend_sub_category=>'Grocery Store',:spend_sub_category_details=>'Grocery Store')
    TransactionCategory.create(:spend_category_name=>'Health & Insurance',:user_id=>self.id,:spend_sub_category=>'Dental Care',:spend_sub_category_details=>'Dental Care')
    TransactionCategory.create(:spend_category_name=>'Health & Insurance',:user_id=>self.id,:spend_sub_category=>'Eye Care',:spend_sub_category_details=>'Eye Care')
    TransactionCategory.create(:spend_category_name=>'Health & Insurance',:user_id=>self.id,:spend_sub_category=>'Insurance',:spend_sub_category_details=>'Insurance')
    TransactionCategory.create(:spend_category_name=>'Health & Insurance',:user_id=>self.id,:spend_sub_category=>'Pharmacy',:spend_sub_category_details=>'Pharmacy')
    TransactionCategory.create(:spend_category_name=>'Health & Insurance',:user_id=>self.id,:spend_sub_category=>'Primary Care',:spend_sub_category_details=>'Primary Care')
    TransactionCategory.create(:spend_category_name=>'Health & Insurance',:user_id=>self.id,:spend_sub_category=>'Other',:spend_sub_category_details=>'Other')
    TransactionCategory.create(:spend_category_name=>'Home',:user_id=>self.id,:spend_sub_category=>'Furniture',:spend_sub_category_details=>'Furniture')
    TransactionCategory.create(:spend_category_name=>'Home',:user_id=>self.id,:spend_sub_category=>'Home Improvement',:spend_sub_category_details=>'Home Improvement')
    TransactionCategory.create(:spend_category_name=>'Pets',:user_id=>self.id,:spend_sub_category=>'Pet Food & Supplies',:spend_sub_category_details=>'Pet Food & Supplies')
    TransactionCategory.create(:spend_category_name=>'Pets',:user_id=>self.id,:spend_sub_category=>'Veterinary Services',:spend_sub_category_details=>'Veterinary Services')
    TransactionCategory.create(:spend_category_name=>'Rent / Mortgage',:user_id=>self.id,:spend_sub_category=>'Mortgage',:spend_sub_category_details=>'Mortgage')
    TransactionCategory.create(:spend_category_name=>'Rent / Mortgage',:user_id=>self.id,:spend_sub_category=>'Rent',:spend_sub_category_details=>'Rent')
    TransactionCategory.create(:spend_category_name=>'Services',:user_id=>self.id,:spend_sub_category=>'Financial Advisor',:spend_sub_category_details=>'Financial Advisor')
    TransactionCategory.create(:spend_category_name=>'Services',:user_id=>self.id,:spend_sub_category=>'Legal Fees',:spend_sub_category_details=>'Legal Fees')
    TransactionCategory.create(:spend_category_name=>'Services',:user_id=>self.id,:spend_sub_category=>'Childcare',:spend_sub_category_details=>'Childcare')
    TransactionCategory.create(:spend_category_name=>'Services',:user_id=>self.id,:spend_sub_category=>'Other',:spend_sub_category_details=>'Other')
    TransactionCategory.create(:spend_category_name=>'Shopping',:user_id=>self.id,:spend_sub_category=>'Clothes & Accessories',:spend_sub_category_details=>'Clothes & Accessories')
    TransactionCategory.create(:spend_category_name=>'Shopping',:user_id=>self.id,:spend_sub_category=>'Department Store',:spend_sub_category_details=>'Department Store')
    TransactionCategory.create(:spend_category_name=>'Shopping',:user_id=>self.id,:spend_sub_category=>'Electronics',:spend_sub_category_details=>'Electronics')
    TransactionCategory.create(:spend_category_name=>'Shopping',:user_id=>self.id,:spend_sub_category=>'Hobbies',:spend_sub_category_details=>'Hobbies')
    TransactionCategory.create(:spend_category_name=>'Shopping',:user_id=>self.id,:spend_sub_category=>'Online',:spend_sub_category_details=>'Online')
    TransactionCategory.create(:spend_category_name=>'Shopping',:user_id=>self.id,:spend_sub_category=>'Superstore',:spend_sub_category_details=>'Superstore')
    TransactionCategory.create(:spend_category_name=>'Shopping',:user_id=>self.id,:spend_sub_category=>'Other',:spend_sub_category_details=>'Other')
    TransactionCategory.create(:spend_category_name=>'Transfer',:user_id=>self.id,:spend_sub_category=>'Incoming',:spend_sub_category_details=>'Incoming Transfer')
    TransactionCategory.create(:spend_category_name=>'Transfer',:user_id=>self.id,:spend_sub_category=>'Outgoing',:spend_sub_category_details=>'Outgoing Transfer')
    TransactionCategory.create(:spend_category_name=>'Travel',:user_id=>self.id,:spend_sub_category=>'Flights',:spend_sub_category_details=>'Flights')
    TransactionCategory.create(:spend_category_name=>'Travel',:user_id=>self.id,:spend_sub_category=>'Hotels',:spend_sub_category_details=>'Hotels')
    TransactionCategory.create(:spend_category_name=>'Travel',:user_id=>self.id,:spend_sub_category=>'Rental Car',:spend_sub_category_details=>'Rental Car')
    TransactionCategory.create(:spend_category_name=>'Travel',:user_id=>self.id,:spend_sub_category=>'Other',:spend_sub_category_details=>'Other')
    TransactionCategory.create(:spend_category_name=>'Income',:user_id=>self.id,:spend_sub_category=>'Interest & Dividends',:spend_sub_category_details=>'Interest & Dividends')
    TransactionCategory.create(:spend_category_name=>'Income',:user_id=>self.id,:spend_sub_category=>'Retirement & Pension',:spend_sub_category_details=>'Retirement & Pension')
    TransactionCategory.create(:spend_category_name=>'Income',:user_id=>self.id,:spend_sub_category=>'Tax Refund',:spend_sub_category_details=>'Tax Refund')
    TransactionCategory.create(:spend_category_name=>'Income',:user_id=>self.id,:spend_sub_category=>'Unemployment',:spend_sub_category_details=>'Unemployment')
    TransactionCategory.create(:spend_category_name=>'Income',:user_id=>self.id,:spend_sub_category=>'Wages',:spend_sub_category_details=>'Wages')
    TransactionCategory.create(:spend_category_name=>'Income',:user_id=>self.id,:spend_sub_category=>'Other',:spend_sub_category_details=>'Other')

    #Below is a manual way to create a budget table for each user
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2022-09-01',:last_day_of_month=>'2022-09-30',:non_school_expenses=>0,:required_school_expenses=>0,:optional_school_expenses=>0,:total_expenses=>0,:total_income=>0)
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2022-10-01',:last_day_of_month=>'2022-10-31',:non_school_expenses=>0,:required_school_expenses=>0,:optional_school_expenses=>0,:total_expenses=>0,:total_income=>0)
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2022-11-01',:last_day_of_month=>'2022-11-30',:non_school_expenses=>0,:required_school_expenses=>0,:optional_school_expenses=>0,:total_expenses=>0,:total_income=>0)
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2022-12-01',:last_day_of_month=>'2022-12-31',:non_school_expenses=>0,:required_school_expenses=>0,:optional_school_expenses=>0,:total_expenses=>0,:total_income=>0)
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2023-01-01',:last_day_of_month=>'2023-01-31',:non_school_expenses=>0,:required_school_expenses=>0,:optional_school_expenses=>0,:total_expenses=>0,:total_income=>0)
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2023-02-01',:last_day_of_month=>'2023-02-28',:non_school_expenses=>0,:required_school_expenses=>0,:optional_school_expenses=>0,:total_expenses=>0,:total_income=>0)
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2023-03-01',:last_day_of_month=>'2023-03-31',:non_school_expenses=>0,:required_school_expenses=>0,:optional_school_expenses=>0,:total_expenses=>0,:total_income=>0)
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2023-04-01',:last_day_of_month=>'2023-04-30',:non_school_expenses=>0,:required_school_expenses=>0,:optional_school_expenses=>0,:total_expenses=>0,:total_income=>0)
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2023-05-01',:last_day_of_month=>'2023-05-31',:non_school_expenses=>0,:required_school_expenses=>0,:optional_school_expenses=>0,:total_expenses=>0,:total_income=>0)
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2023-06-01',:last_day_of_month=>'2023-06-30',:non_school_expenses=>0,:required_school_expenses=>0,:optional_school_expenses=>0,:total_expenses=>0,:total_income=>0)

    #Below is a manual way to create a cash flow table for each user
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-08-28',:last_day_of_week=>'2022-09-03',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-09-04',:last_day_of_week=>'2022-09-10',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-09-11',:last_day_of_week=>'2022-09-17',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-09-18',:last_day_of_week=>'2022-09-24',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-09-25',:last_day_of_week=>'2022-10-01',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-10-02',:last_day_of_week=>'2022-10-08',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-10-09',:last_day_of_week=>'2022-10-15',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-10-16',:last_day_of_week=>'2022-10-22',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-10-23',:last_day_of_week=>'2022-10-29',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-10-30',:last_day_of_week=>'2022-11-05',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-11-06',:last_day_of_week=>'2022-11-12',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-11-13',:last_day_of_week=>'2022-11-19',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-11-20',:last_day_of_week=>'2022-11-26',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-11-27',:last_day_of_week=>'2022-12-03',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-12-04',:last_day_of_week=>'2022-12-10',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-12-11',:last_day_of_week=>'2022-12-17',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-12-18',:last_day_of_week=>'2022-12-24',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2022-12-25',:last_day_of_week=>'2022-12-31',:remaining_cash=>0)

    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-01-01',:last_day_of_week=>'2023-01-07',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-01-08',:last_day_of_week=>'2023-01-14',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-01-15',:last_day_of_week=>'2023-01-21',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-01-22',:last_day_of_week=>'2023-01-28',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-01-29',:last_day_of_week=>'2023-02-04',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-02-05',:last_day_of_week=>'2023-02-11',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-02-12',:last_day_of_week=>'2023-02-18',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-02-19',:last_day_of_week=>'2023-02-25',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-02-26',:last_day_of_week=>'2023-03-04',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-03-05',:last_day_of_week=>'2023-03-11',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-03-12',:last_day_of_week=>'2023-03-18',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-03-19',:last_day_of_week=>'2023-03-25',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-03-26',:last_day_of_week=>'2023-04-01',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-04-02',:last_day_of_week=>'2023-04-08',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-04-09',:last_day_of_week=>'2023-04-15',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-04-16',:last_day_of_week=>'2023-04-22',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-04-23',:last_day_of_week=>'2023-04-29',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-04-30',:last_day_of_week=>'2023-05-06',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-05-07',:last_day_of_week=>'2023-05-13',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-05-14',:last_day_of_week=>'2023-05-20',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-05-21',:last_day_of_week=>'2023-05-27',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-05-28',:last_day_of_week=>'2023-06-03',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-06-04',:last_day_of_week=>'2023-06-10',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-06-11',:last_day_of_week=>'2023-06-17',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-06-18',:last_day_of_week=>'2023-06-24',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-06-25',:last_day_of_week=>'2023-07-01',:remaining_cash=>0)
  
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  private

    # Converts email to all lowercase.
    def downcase_email
      self.email.downcase!
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    # Returns the hash digest of the given string.
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

end
