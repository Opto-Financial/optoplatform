class PlaidClient
	def initialize
		configuration = Plaid::Configuration.new
		configuration.server_index = Plaid::Configuration::Environment["sandbox"]
		# clientID and secrets to be moved to env variables
		configuration.api_key["PLAID-CLIENT-ID"] = "62e9fc1a50f8030013968af0"
    configuration.api_key["PLAID-SECRET"] = "e863c9a11046dec35f60ef08d7b4af"

		api_client = Plaid::ApiClient.new(
			configuration
		)

		@client = Plaid::PlaidApi.new(api_client)
	end

	def create_link_token(user_id)
		link_token_create_request = Plaid::LinkTokenCreateRequest.new({
      user: { client_user_id: user_id },
      client_name: 'Opto',
      products: %w[auth transactions liabilities],
      country_codes: ['US'],
      language: 'en'
    })

    link_token_response = @client.link_token_create(
      link_token_create_request
    )

    link_token = link_token_response.link_token

    @client.link_token_get(Plaid::LinkTokenGetRequest.new({ link_token: link_token }))
	end

	def exchange_token(public_token)
		request = Plaid::ItemPublicTokenExchangeRequest.new
    request.public_token = public_token

    @client.item_public_token_exchange(request)
	end

	def get_accounts(access_token)
		request = Plaid::AccountsGetRequest.new({ access_token: access_token })
		@client.accounts_get(request)
	end


	def get_transactions(access_token)
		@client.transactions.get(access_token)
	end

	def sync_transactions(plaid_item)
		cursor = plaid_item.transactions_cursor

		added = []
		modified = []
		removed = [] # Removed transaction ids
		has_more = true

		while has_more
			request = Plaid::TransactionsSyncRequest.new(
				{
					access_token: plaid_item.plaid_access_token,
					cursor: cursor
				}
			)

			response = @client.transactions_sync(request)

			# Add this page of results
			added    += response.added
			modified += response.modified
			removed  += response.removed

			has_more = response.has_more

			# Update cursor to the next cursor
			cursor = response.next_cursor
		end

		# Adjust transactions accordingly

		added.each do |t|

			account = Account.find_by(plaid_account_id: t.account_id)
			next if account.nil?

			transaction_datetime = t.datetime ? t.datetime : t.date
			authorized_datetime = t.authorized_datetime ? t.authorized_datetime : t.authorized_date
			
			Transaction.create!(
				transaction_amount: t.amount,
				transaction_datetime: transaction_datetime,
				name_plaid: t.name,
				merchant_name: t.merchant_name,
				authorized_datetime: authorized_datetime,
				account: account,
				pending:	t.pending,
				plaid_transaction_id: t.transaction_id,
				payment_channel: t.payment_channel
			)
		end

		# Persist cursor and updated data
		plaid_item.transactions_cursor = cursor
		plaid_item.save!
	end

	def get_balance(access_token)
		@client.balance.get(access_token)
	end

	def get_identity(access_token)
		@client.identity.get(access_token)
	end

	def get_auth(access_token)
		@client.auth.get(access_token)
	end

	def get_income(access_token)
		@client.income.get(access_token)
	end

	def get_assets(access_token)
		@client.asset_report.get(access_token)
	end

	def create_asset_report(access_token)
		@client.asset_report.create([access_token], 10)
	end

	def get_asset_report(asset_report_token)
		@client.asset_report.get(asset_report_token)
	end

	def get_asset_report_pdf(asset_report_token)
		@client.asset_report.get_pdf(asset_report_token)
	end

	def create_audit_copy(asset_report_token)
		@client.asset_report.audit_copy.create(asset_report_token)
	end
end
