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

  # Routes for the School event payment resource:

  # CREATE
  post("/insert_school_event_payment", { :controller => "school_event_payments", :action => "create" })
          
  # READ
  get("/school_event_payments", { :controller => "school_event_payments", :action => "index" })
  
  get("/school_event_payments/:path_id", { :controller => "school_event_payments", :action => "show" })
  
  # UPDATE
  
  post("/modify_school_event_payment/:path_id", { :controller => "school_event_payments", :action => "update" })
  
  # DELETE
  get("/delete_school_event_payment/:path_id", { :controller => "school_event_payments", :action => "destroy" })

  #------------------------------

  # Routes for the School fee resource:

  # CREATE
  post("/insert_school_fee", { :controller => "school_fees", :action => "create" })
          
  # READ
  get("/school_fees", { :controller => "school_fees", :action => "index" })
  
  get("/school_fees/:path_id", { :controller => "school_fees", :action => "show" })
  
  # UPDATE
  
  post("/modify_school_fee/:path_id", { :controller => "school_fees", :action => "update" })
  
  # DELETE
  get("/delete_school_fee/:path_id", { :controller => "school_fees", :action => "destroy" })

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

  # Routes for the Spend intention resource:

  # CREATE
  post("/insert_spend_intention", { :controller => "spend_intentions", :action => "create" })
          
  # READ
  get("/spend_intentions", { :controller => "spend_intentions", :action => "index" })
  
  get("/spend_intentions/:path_id", { :controller => "spend_intentions", :action => "show" })
  
  # UPDATE
  
  post("/modify_spend_intention/:path_id", { :controller => "spend_intentions", :action => "update" })
  
  # DELETE
  get("/delete_spend_intention/:path_id", { :controller => "spend_intentions", :action => "destroy" })

  #------------------------------

  # Routes for the Loan disbursement resource:

  # CREATE
  post("/insert_loan_disbursement", { :controller => "loan_disbursements", :action => "create" })
          
  # READ
  get("/loan_disbursements", { :controller => "loan_disbursements", :action => "index" })
  
  get("/loan_disbursements/:path_id", { :controller => "loan_disbursements", :action => "show" })
  
  # UPDATE
  
  post("/modify_loan_disbursement/:path_id", { :controller => "loan_disbursements", :action => "update" })
  
  # DELETE
  get("/delete_loan_disbursement/:path_id", { :controller => "loan_disbursements", :action => "destroy" })

  #------------------------------

  # Routes for the School event resource:

  # CREATE
  post("/insert_school_event", { :controller => "school_events", :action => "create" })
          
  # READ
  get("/school_events", { :controller => "school_events", :action => "index" })
  
  get("/school_events/:path_id", { :controller => "school_events", :action => "show" })
  
  # UPDATE
  
  post("/modify_school_event/:path_id", { :controller => "school_events", :action => "update" })
  
  # DELETE
  get("/delete_school_event/:path_id", { :controller => "school_events", :action => "destroy" })

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

  # Routes for the Loan comparison resource:

  # CREATE
  post("/insert_loan_comparison", { :controller => "loan_comparisons", :action => "create" })
          
  # READ
  get("/loan_comparisons", { :controller => "loan_comparisons", :action => "index" })
  
  get("/loan_comparisons/:path_id", { :controller => "loan_comparisons", :action => "show" })
  
  # UPDATE
  
  post("/modify_loan_comparison/:path_id", { :controller => "loan_comparisons", :action => "update" })
  
  # DELETE
  get("/delete_loan_comparison/:path_id", { :controller => "loan_comparisons", :action => "destroy" })

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
  get 'password/reset/edit', to: "user_authentication#edit_reset"
  patch 'password/reset/edit', to: "user_authentication#update_reset"
  
end
