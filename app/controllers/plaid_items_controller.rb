class PlaidItemsController < ApplicationController
  def index
    #matching_plaid_items = PlaidItem.all
    matching_plaid_items = PlaidItem.where({user_id: @current_user.id})

    @list_of_plaid_items = matching_plaid_items.order({ :created_at => :desc })

    render({ :template => "plaid_items/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_plaid_items = PlaidItem.where({ :id => the_id })

    @the_plaid_item = matching_plaid_items.at(0)

    render({ :template => "plaid_items/show.html.erb" })
  end

  def create_link_token
    response = PlaidClient.new.create_link_token(@current_user.id.to_s)

    # Need to handle error handling here

    render json: response
  end

  def create_access_token
    response = PlaidClient.new.exchange_token(params[:public_token])

    Finance::SubmitPlaidItem.call(
      plaid_access_token: response.access_token, plaid_item_id: response.item_id, user: @current_user
    )

    # Need to handle error handling here

    render json: response
  end


  def create
    the_plaid_item = PlaidItem.new
    the_plaid_item.user_id = params.fetch("query_user_id")
    the_plaid_item.plaid_access_token = params.fetch("query_plaid_access_token")
    the_plaid_item.plaid_item_id = params.fetch("query_plaid_item_id")
    the_plaid_item.plaid_institution_id = params.fetch("query_plaid_institution_id")
    the_plaid_item.status = params.fetch("query_status")
    the_plaid_item.transactions_cursor = params.fetch("query_transactions_cursor")
    the_plaid_item.accounts_count = params.fetch("query_accounts_count")

    if the_plaid_item.valid?
      the_plaid_item.save
      redirect_to("/plaid_items", { :notice => "Plaid item created successfully." })
    else
      redirect_to("/plaid_items", { :alert => the_plaid_item.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_plaid_item = PlaidItem.where({ :id => the_id }).at(0)

    the_plaid_item.user_id = params.fetch("query_user_id")
    the_plaid_item.plaid_access_token = params.fetch("query_plaid_access_token")
    the_plaid_item.plaid_item_id = params.fetch("query_plaid_item_id")
    the_plaid_item.plaid_institution_id = params.fetch("query_plaid_institution_id")
    the_plaid_item.status = params.fetch("query_status")
    the_plaid_item.transactions_cursor = params.fetch("query_transactions_cursor")
    the_plaid_item.accounts_count = params.fetch("query_accounts_count")

    if the_plaid_item.valid?
      the_plaid_item.save
      redirect_to("/plaid_items/#{the_plaid_item.id}", { :notice => "Plaid item updated successfully."} )
    else
      redirect_to("/plaid_items/#{the_plaid_item.id}", { :alert => the_plaid_item.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_plaid_item = PlaidItem.where({ :id => the_id }).at(0)

    the_plaid_item.destroy

    redirect_to("/plaid_items", { :notice => "Plaid item deleted successfully."} )
  end
end
