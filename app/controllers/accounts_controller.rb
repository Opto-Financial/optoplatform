class AccountsController < ApplicationController
  def index
    #matching_accounts = Account.all
    matching_accounts = Account.where({user_id: @current_user.id})

    @list_of_accounts = matching_accounts.order({ :created_at => :desc })

    render({ :template => "accounts/index.html.erb" })
  end

  
  def show
    the_id = params.fetch("path_id")

    matching_accounts = Account.where({ :id => the_id })

    @the_account = matching_accounts.at(0)

    render({ :template => "accounts/show.html.erb" })
  end


  def create
    the_account = Account.new
    the_account.account_type = params.fetch("query_account_type")
    the_account.user_id = params.fetch("query_user_id")
    the_account.item_id = params.fetch("query_item_id")
    the_account.name_plaid = params.fetch("query_name_plaid")
    the_account.plaid_account_id = params.fetch("query_plaid_account_id")
    the_account.mask_plaid = params.fetch("query_mask_plaid")
    the_account.official_name_plaid = params.fetch("query_official_name_plaid")
    the_account.current_balance_plaid = params.fetch("query_current_balance_plaid")
    the_account.available_balance_plaid = params.fetch("query_available_balance_plaid")
    the_account.iso_currency_code_plaid = params.fetch("query_iso_currency_code_plaid")
    the_account.type_plaid = params.fetch("query_type_plaid")
    the_account.subtype_plaid = params.fetch("query_subtype_plaid")
    the_account.credit_cards_count = params.fetch("query_credit_cards_count")

    if the_account.valid?
      the_account.save
      redirect_to("/accounts", { :notice => "Account created successfully." })
    else
      redirect_to("/accounts", { :alert => the_account.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_account = Account.where({ :id => the_id }).at(0)

    the_account.account_type = params.fetch("query_account_type")
    the_account.user_id = params.fetch("query_user_id")
    the_account.item_id = params.fetch("query_item_id")
    the_account.name_plaid = params.fetch("query_name_plaid")
    the_account.plaid_account_id = params.fetch("query_plaid_account_id")
    the_account.mask_plaid = params.fetch("query_mask_plaid")
    the_account.official_name_plaid = params.fetch("query_official_name_plaid")
    the_account.current_balance_plaid = params.fetch("query_current_balance_plaid")
    the_account.available_balance_plaid = params.fetch("query_available_balance_plaid")
    the_account.iso_currency_code_plaid = params.fetch("query_iso_currency_code_plaid")
    the_account.type_plaid = params.fetch("query_type_plaid")
    the_account.subtype_plaid = params.fetch("query_subtype_plaid")
    the_account.credit_cards_count = params.fetch("query_credit_cards_count")

    if the_account.valid?
      the_account.save
      redirect_to("/accounts/#{the_account.id}", { :notice => "Account updated successfully."} )
    else
      redirect_to("/accounts/#{the_account.id}", { :alert => the_account.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_account = Account.where({ :id => the_id }).at(0)

    the_account.destroy

    redirect_to("/accounts", { :notice => "Account deleted successfully."} )
  end
end
