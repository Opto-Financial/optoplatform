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
