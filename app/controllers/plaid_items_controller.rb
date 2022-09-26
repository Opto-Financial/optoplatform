class PlaidItemsController < ApplicationController
  def index
    matching_plaid_items = PlaidItem.all

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
    configuration = Plaid::Configuration.new
    configuration.server_index = Plaid::Configuration::Environment["sandbox"]
    configuration.api_key["PLAID-CLIENT-ID"] = "62e9fc1a50f8030013968af0"
    configuration.api_key["PLAID-SECRET"] = "e863c9a11046dec35f60ef08d7b4af"

    api_client = Plaid::ApiClient.new(
      configuration
    )

    client = Plaid::PlaidApi.new(api_client)

    client_user_id = @current_user.id
    
    # Create the link_token with all of your configurations
    link_token_create_request = Plaid::LinkTokenCreateRequest.new({
      :user => { :client_user_id => client_user_id.to_s },
      :client_name => 'Opto',
      :products => %w[auth transactions],
      :country_codes => ['US'],
      :language => 'en'
    })

    link_token_response = client.link_token_create(
      link_token_create_request
    )

    # Pass the result to your client-side app to initialize Link
    #  and retrieve a public_token
    link_token = link_token_response.link_token

    request = Plaid::LinkTokenGetRequest.new({ link_token: link_token })
    response = client.link_token_get(request)

    render json: response
  end

  def create_access_token
    configuration = Plaid::Configuration.new
    configuration.server_index = Plaid::Configuration::Environment["sandbox"]
    configuration.api_key["PLAID-CLIENT-ID"] = "62e9fc1a50f8030013968af0"
    configuration.api_key["PLAID-SECRET"] = "e863c9a11046dec35f60ef08d7b4af"

    api_client = Plaid::ApiClient.new(
      configuration
    )

    client = Plaid::PlaidApi.new(api_client)

    request = Plaid::ItemPublicTokenExchangeRequest.new
    request.public_token = params.fetch("public_token")

    response = client.item_public_token_exchange(request)

    # response contains the access token and item id.
    # response.access_token
    # response.item_id

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
