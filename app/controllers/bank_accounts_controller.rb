class BankAccountsController < ApplicationController
  def index
    matching_bank_accounts = BankAccount.where({user_id: @current_user.id})

    @list_of_bank_accounts = matching_bank_accounts.order({ :created_at => :desc })

    render({ :template => "bank_accounts/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_bank_accounts = BankAccount.where({ :id => the_id })

    @the_bank_account = matching_bank_accounts.at(0)

    render({ :template => "bank_accounts/show.html.erb" })
  end

  def create
    the_bank_account = BankAccount.new
    the_bank_account.account_balance = params.fetch("query_account_balance")
    the_bank_account.savings_account_flag = params.fetch("query_savings_account_flag", false)
    the_bank_account.asset_id = params.fetch("query_asset_id")
    the_bank_account.plaid_account_id = params.fetch("query_plaid_account_id")
    the_bank_account.account_id = params.fetch("query_account_id")

    if the_bank_account.valid?
      the_bank_account.save
      redirect_to("/bank_accounts", { :notice => "Bank account created successfully." })
    else
      redirect_to("/bank_accounts", { :alert => the_bank_account.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_bank_account = BankAccount.where({ :id => the_id }).at(0)

    the_bank_account.account_balance = params.fetch("query_account_balance")
    the_bank_account.savings_account_flag = params.fetch("query_savings_account_flag", false)
    the_bank_account.asset_id = params.fetch("query_asset_id")
    the_bank_account.plaid_account_id = params.fetch("query_plaid_account_id")
    the_bank_account.account_id = params.fetch("query_account_id")

    if the_bank_account.valid?
      the_bank_account.save
      redirect_to("/bank_accounts/#{the_bank_account.id}", { :notice => "Bank account updated successfully."} )
    else
      redirect_to("/bank_accounts/#{the_bank_account.id}", { :alert => the_bank_account.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_bank_account = BankAccount.where({ :id => the_id }).at(0)

    the_bank_account.destroy

    redirect_to("/bank_accounts", { :notice => "Bank account deleted successfully."} )
  end
end
