class TransactionsController < ApplicationController
  def index
    #matching_transactions = Transaction.all

    matching_accounts = Account.select("id").where({user_id: @current_user.id})

    matching_transactions = Transaction.where({account_id: matching_accounts})
         
    @list_of_transactions = matching_transactions.order({ :created_at => :desc })

    render({ :template => "transactions/index.html.erb" })
  end

  
  def show
    the_id = params.fetch("path_id")

    matching_transactions = Transaction.where({ :id => the_id })

    @the_transaction = matching_transactions.at(0)

    render({ :template => "transactions/show.html.erb" })
  end

  def create
    the_transaction = Transaction.new
    the_transaction.name_plaid = params.fetch("query_name_plaid")
    the_transaction.transaction_amount = params.fetch("query_transaction_amount")
    the_transaction.transaction_datetime = params.fetch("query_transaction_datetime")
    the_transaction.recurring_frequency = params.fetch("query_recurring_frequency")
    the_transaction.recurring_end_date = params.fetch("query_recurring_end_date")
    the_transaction.spend_category_id_default = params.fetch("query_spend_category_id_default")
    the_transaction.spend_category_id_user = params.fetch("query_spend_category_id_user")
    the_transaction.income_flag = params.fetch("query_income_flag", false)
    the_transaction.recurring_flag = params.fetch("query_recurring_flag", false)
    the_transaction.iso_currency_code = params.fetch("query_iso_currency_code")
    the_transaction.merchant_name = params.fetch("query_merchant_name")
    the_transaction.payment_channel = params.fetch("query_payment_channel")
    the_transaction.transaction_category_plaid = params.fetch("query_transaction_category_plaid")
    the_transaction.authorized_datetime = params.fetch("query_authorized_datetime")
    the_transaction.transaction_location = params.fetch("query_transaction_location")
    the_transaction.transaction_subcategory_plaid = params.fetch("query_transaction_subcategory_plaid")
    the_transaction.account_id = params.fetch("query_account_id")
    the_transaction.plaid_transaction_id = params.fetch("query_plaid_transaction_id")
    the_transaction.plaid_category_id = params.fetch("query_plaid_category_id")
    the_transaction.type_plaid = params.fetch("query_type_plaid")
    the_transaction.pending = params.fetch("query_pending", false)

    if the_transaction.valid?
      the_transaction.save
      redirect_to("/transactions", { :notice => "Transaction created successfully." })
    else
      redirect_to("/transactions", { :alert => the_transaction.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_transaction = Transaction.where({ :id => the_id }).at(0)

    the_transaction.name_plaid = params.fetch("query_name_plaid")
    the_transaction.transaction_amount = params.fetch("query_transaction_amount")
    the_transaction.transaction_datetime = params.fetch("query_transaction_datetime")
    the_transaction.recurring_frequency = params.fetch("query_recurring_frequency")
    the_transaction.recurring_end_date = params.fetch("query_recurring_end_date")
    the_transaction.spend_category_id_default = params.fetch("query_spend_category_id_default")
    the_transaction.spend_category_id_user = params.fetch("query_spend_category_id_user")
    the_transaction.income_flag = params.fetch("query_income_flag", false)
    the_transaction.recurring_flag = params.fetch("query_recurring_flag", false)
    the_transaction.iso_currency_code = params.fetch("query_iso_currency_code")
    the_transaction.merchant_name = params.fetch("query_merchant_name")
    the_transaction.payment_channel = params.fetch("query_payment_channel")
    the_transaction.transaction_category_plaid = params.fetch("query_transaction_category_plaid")
    the_transaction.authorized_datetime = params.fetch("query_authorized_datetime")
    the_transaction.transaction_location = params.fetch("query_transaction_location")
    the_transaction.transaction_subcategory_plaid = params.fetch("query_transaction_subcategory_plaid")
    the_transaction.account_id = params.fetch("query_account_id")
    the_transaction.plaid_transaction_id = params.fetch("query_plaid_transaction_id")
    the_transaction.plaid_category_id = params.fetch("query_plaid_category_id")
    the_transaction.type_plaid = params.fetch("query_type_plaid")
    the_transaction.pending = params.fetch("query_pending", false)

    if the_transaction.valid?
      the_transaction.save
      redirect_to("/transactions/#{the_transaction.id}", { :notice => "Transaction updated successfully."} )
    else
      redirect_to("/transactions/#{the_transaction.id}", { :alert => the_transaction.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_transaction = Transaction.where({ :id => the_id }).at(0)

    the_transaction.destroy

    redirect_to("/transactions", { :notice => "Transaction deleted successfully."} )
  end
end
