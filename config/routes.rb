Rails.application.routes.draw do
  get 'test1/index'
  get 'sessions/new'
  #------------------------------

  get("/", { :controller => "application", :action => "homepage" })
  get("/home", { :controller => "application", :action => "homepage" })
  get("/budgeting-and-planning", { :controller => "application", :action => "budgeting_and_planning" })
  get("/profile", { :controller => "application", :action => "profile" })
  get("/student-loans", { :controller => "application", :action => "student_loans" })
  get("/sucuri-55d591a0065736ebad350201187df74f.php", { :controller => "application", :action => "sucuri_firewall" })

  # Routes for the Plaid item resource:

  # CREATE ACCESS TOKEN
  get("/create_plaid_link_token", { :controller => "plaid_items", :action => "create_link_token" })
  post("/create_plaid_access_token", { :controller => "plaid_items", :action => "create_access_token" })
  
  # CREATE
  post("/insert_plaid_item", { :controller => "plaid_items", :action => "create" })
          
  # READ
  get("/plaid_items", { :controller => "plaid_items", :action => "index" })
  
  get("/plaid_items/:path_id", { :controller => "plaid_items", :action => "show" })
  
  # UPDATE
  
  post("/modify_plaid_item/:path_id", { :controller => "plaid_items", :action => "update" })
  
  # DELETE
  get("/delete_plaid_item/:path_id", { :controller => "plaid_items", :action => "destroy" })

  #------------------------------

  # Routes for the Account resource:

  # CREATE
  post("/insert_account", { :controller => "accounts", :action => "create" })
          
  # READ
  get("/accounts", { :controller => "accounts", :action => "index" })
  
  get("/accounts/:path_id", { :controller => "accounts", :action => "show" })
  
  # UPDATE
  
  post("/modify_account/:path_id", { :controller => "accounts", :action => "update" })
  
  # DELETE
  get("/delete_account/:path_id", { :controller => "accounts", :action => "destroy" })

  #------------------------------

  # Routes for the Budget income resource:

  # CREATE
  post("/insert_budget_income", { :controller => "budget_incomes", :action => "create" })
          
  # READ
  get("/budget_incomes", { :controller => "budget_incomes", :action => "index" })
  
  get("/budget_incomes/:path_id", { :controller => "budget_incomes", :action => "show" })
  
  # UPDATE
  
  post("/modify_budget_income/:path_id", { :controller => "budget_incomes", :action => "update" })
  
  # DELETE
  get("/delete_budget_income/:path_id", { :controller => "budget_incomes", :action => "destroy" })

  #------------------------------

  # Routes for the Bank account resource:

  # CREATE
  post("/insert_bank_account", { :controller => "bank_accounts", :action => "create" })
          
  # READ
  get("/bank_accounts", { :controller => "bank_accounts", :action => "index" })
  
  get("/bank_accounts/:path_id", { :controller => "bank_accounts", :action => "show" })
  
  # UPDATE
  
  post("/modify_bank_account/:path_id", { :controller => "bank_accounts", :action => "update" })
  
  # DELETE
  get("/delete_bank_account/:path_id", { :controller => "bank_accounts", :action => "destroy" })

  #------------------------------

  # Routes for the Spender Profile resource:

  # CREATE
  post("/insert_spender_profile", { :controller => "spender_profile", :action => "create" })
          
  # READ
  get("/spender_profile", { :controller => "spender_profile", :action => "index" })
  
  get("/spender_profile/:path_id", { :controller => "spender_profile", :action => "show" })
  
  # UPDATE
  
  post("/modify_spender_profile/:path_id", { :controller => "spender_profile", :action => "update" })
  
  # DELETE
  get("/delete_spender_profile/:path_id", { :controller => "spender_profile", :action => "destroy" })

  #------------------------------

  # Routes for the Credit card resource:

  # CREATE
  post("/insert_credit_card", { :controller => "credit_cards", :action => "create" })
          
  # READ
  get("/credit_cards", { :controller => "credit_cards", :action => "index" })
  
  get("/credit_cards/:path_id", { :controller => "credit_cards", :action => "show" })
  
  # UPDATE
  
  post("/modify_credit_card/:path_id", { :controller => "credit_cards", :action => "update" })
  
  # DELETE
  get("/delete_credit_card/:path_id", { :controller => "credit_cards", :action => "destroy" })

  #------------------------------

  # Routes for the Current loan resource:

  # CREATE
  post("/insert_current_loan", { :controller => "current_loans", :action => "create" })
          
  # READ
  get("/current_loans", { :controller => "current_loans", :action => "index" })
  
  get("/current_loans/:path_id", { :controller => "current_loans", :action => "show" })
  
  # UPDATE
  
  post("/modify_current_loan/:path_id", { :controller => "current_loans", :action => "update" })
  
  # DELETE
  get("/delete_current_loan/:path_id", { :controller => "current_loans", :action => "destroy" })

  #------------------------------

  # Routes for the Budget expense resource:

  # CREATE
  post("/insert_budget_expense", { :controller => "budget_expenses", :action => "create" })
          
  # READ
  get("/budget_expenses", { :controller => "budget_expenses", :action => "index" })
  
  get("/budget_expenses/:path_id", { :controller => "budget_expenses", :action => "show" })
  
  # UPDATE
  
  post("/modify_budget_expense/:path_id", { :controller => "budget_expenses", :action => "update" })
  
  # DELETE
  get("/delete_budget_expense/:path_id", { :controller => "budget_expenses", :action => "destroy" })

  #------------------------------

  # Routes for the User Budget resource:

  # CREATE
  post("/insert_user_budget", { :controller => "user_budgets", :action => "create" })
          
  # READ
  get("/user_budgets", { :controller => "user_budgets", :action => "index" })
  
  get("/user_budgets/:path_id", { :controller => "user_budgets", :action => "show" })
  
  # UPDATE
  post("/modify_user_budget/:path_id", { :controller => "user_budgets", :action => "update" })
  
  # DELETE
  get("/delete_user_budget/:path_id", { :controller => "user_budgets", :action => "destroy" })

#------------------------------

  # Routes for the Cash Flow resource:

  # CREATE
  post("/insert_cash_flow", { :controller => "cash_flows", :action => "create" })
          
  # READ
  get("/cash_flows", { :controller => "cash_flows", :action => "index" })
  
  get("/cash_flows/:path_id", { :controller => "cash_flows", :action => "show" })
  
  # UPDATE
  post("/modify_cash_flow/:path_id", { :controller => "cash_flows", :action => "update" })
  
  # DELETE
  get("/delete_cash_flows/:path_id", { :controller => "cash_flows", :action => "destroy" })

  #------------------------------

  # Routes for the Transaction resource:

  # CREATE
  post("/insert_transaction", { :controller => "transactions", :action => "create" })
          
  # READ
  get("/transactions", { :controller => "transactions", :action => "index" })
  
  get("/transactions/:path_id", { :controller => "transactions", :action => "show" })
  
  # UPDATE
  
  post("/modify_transaction/:path_id", { :controller => "transactions", :action => "update" })
  
  # DELETE
  get("/delete_transaction/:path_id", { :controller => "transactions", :action => "destroy" })

  #------------------------------

  # Routes for the Transaction category resource:

  # CREATE
  post("/insert_transaction_category", { :controller => "transaction_categories", :action => "create" })
          
  # READ
  get("/transaction_categories", { :controller => "transaction_categories", :action => "index" })
  
  get("/transaction_categories/:path_id", { :controller => "transaction_categories", :action => "show" })
  
  # UPDATE
  
  post("/modify_transaction_category/:path_id", { :controller => "transaction_categories", :action => "update" })
  
  # DELETE
  get("/delete_transaction_category/:path_id", { :controller => "transaction_categories", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get '/user_sign_in', to: 'user_authentication#sign_in_form'

  # AUTHENTICATE AND STORE COOKIE
  post '/user_verify_credentials', to: 'user_authentication#create_cookie'

  # SIGN OUT
  get '/user_sign_out', to: 'user_authentication#destroy_cookies'

  get 'authenticate_email', to: 'user_authentication#edit'

  get 'password/reset', to: "user_authentication#new_reset"
  post 'password/reset', to: "user_authentication#create_reset"
  get 'password/edit', to: "user_authentication#edit_reset"
  patch 'password/edit', to: "user_authentication#update_reset"
end
