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
#  reset_digest                 :string
#  reset_sent_at                :datetime
#  school                       :string
#  school_events_count          :integer
#  spend_intentions_count       :integer
#  transaction_categories_count :integer
#  user_budgets_count           :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
class User < ApplicationRecord
  attr_accessor :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:spender_profiles, { :class_name => "SpenderProfile", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:accounts, { :class_name => "Account", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:budget_expenses, { :class_name => "BudgetExpense", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:budget_incomes, { :class_name => "BudgetIncome", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:other_loans, { :class_name => "OtherLoan", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:transaction_categories_users, { :class_name => "TransactionCategoriesUser", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:plaid_items, { :class_name => "PlaidItem", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:user_budgets, { :class_name => "UserBudget", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:cash_flows, { :class_name => "CashFlow", :foreign_key => "user_id", :dependent => :destroy })

  #Un-comment out the line below if you add new defaults
  #after_create :set_defaults

  def set_defaults

    #Below is a manual way to create a budget table for each user
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2023-07-01',:last_day_of_month=>'2023-07-31',:total_expenses=>0,:total_income=>0)  
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2023-08-01',:last_day_of_month=>'2023-08-31',:total_expenses=>0,:total_income=>0)  
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2023-09-01',:last_day_of_month=>'2023-09-30',:total_expenses=>0,:total_income=>0)  
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2023-10-01',:last_day_of_month=>'2023-10-31',:total_expenses=>0,:total_income=>0)  
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2023-11-01',:last_day_of_month=>'2023-11-30',:total_expenses=>0,:total_income=>0)  
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2023-12-01',:last_day_of_month=>'2023-12-31',:total_expenses=>0,:total_income=>0)  
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2024-01-01',:last_day_of_month=>'2024-01-31',:total_expenses=>0,:total_income=>0)  
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2024-02-01',:last_day_of_month=>'2024-02-29',:total_expenses=>0,:total_income=>0)  
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2024-03-01',:last_day_of_month=>'2024-03-31',:total_expenses=>0,:total_income=>0)  
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2024-04-01',:last_day_of_month=>'2024-04-30',:total_expenses=>0,:total_income=>0)  
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2024-05-01',:last_day_of_month=>'2024-05-31',:total_expenses=>0,:total_income=>0)  
    UserBudget.create(:user_id=>self.id,:first_day_of_month=>'2024-06-01',:last_day_of_month=>'2024-06-30',:total_expenses=>0,:total_income=>0)  

    #Below is a manual way to create a cash flow table for each user
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-07-23',:last_day_of_week=>'2023-07-29',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-07-30',:last_day_of_week=>'2023-08-05',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-08-06',:last_day_of_week=>'2023-08-12',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-08-13',:last_day_of_week=>'2023-08-19',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-08-20',:last_day_of_week=>'2023-08-26',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-08-27',:last_day_of_week=>'2023-09-02',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-09-03',:last_day_of_week=>'2023-09-09',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-09-10',:last_day_of_week=>'2023-09-16',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-09-17',:last_day_of_week=>'2023-09-23',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-09-24',:last_day_of_week=>'2023-09-30',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-10-01',:last_day_of_week=>'2023-10-07',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-10-08',:last_day_of_week=>'2023-10-14',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-10-15',:last_day_of_week=>'2023-10-21',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-10-22',:last_day_of_week=>'2023-10-28',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-10-29',:last_day_of_week=>'2023-11-04',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-11-05',:last_day_of_week=>'2023-11-11',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-11-12',:last_day_of_week=>'2023-11-18',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-11-19',:last_day_of_week=>'2023-11-25',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-11-26',:last_day_of_week=>'2023-12-02',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-12-03',:last_day_of_week=>'2023-12-09',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-12-10',:last_day_of_week=>'2023-12-16',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-12-17',:last_day_of_week=>'2023-12-23',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-12-24',:last_day_of_week=>'2023-12-30',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2023-12-31',:last_day_of_week=>'2024-01-06',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-01-07',:last_day_of_week=>'2024-01-13',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-01-14',:last_day_of_week=>'2024-01-20',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-01-21',:last_day_of_week=>'2024-01-27',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-01-28',:last_day_of_week=>'2024-02-03',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-02-04',:last_day_of_week=>'2024-02-10',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-02-11',:last_day_of_week=>'2024-02-17',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-02-18',:last_day_of_week=>'2024-02-24',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-02-25',:last_day_of_week=>'2024-03-02',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-03-03',:last_day_of_week=>'2024-03-09',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-03-10',:last_day_of_week=>'2024-03-16',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-03-17',:last_day_of_week=>'2024-03-23',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-03-24',:last_day_of_week=>'2024-03-30',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-03-31',:last_day_of_week=>'2024-04-06',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-04-07',:last_day_of_week=>'2024-04-13',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-04-14',:last_day_of_week=>'2024-04-20',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-04-21',:last_day_of_week=>'2024-04-27',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-04-28',:last_day_of_week=>'2024-05-04',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-05-05',:last_day_of_week=>'2024-05-11',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-05-12',:last_day_of_week=>'2024-05-18',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-05-19',:last_day_of_week=>'2024-05-25',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-05-26',:last_day_of_week=>'2024-06-01',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-06-02',:last_day_of_week=>'2024-06-08',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-06-09',:last_day_of_week=>'2024-06-15',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-06-16',:last_day_of_week=>'2024-06-22',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-06-23',:last_day_of_week=>'2024-06-29',:remaining_cash=>0)
    CashFlow.create(:user_id=>self.id,:first_day_of_week=>'2024-06-30',:last_day_of_week=>'2024-07-06',:remaining_cash=>0)

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


  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
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
