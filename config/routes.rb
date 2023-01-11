Rails.application.routes.draw do
  #------------------------------

  get("/", { :controller => "application", :action => "homepage" })
  get '/home', to: 'application#homepage'
  get '/budgeting-and-planning', to: 'application#budgeting_and_planning'
  get '/profile', to: 'application#profile'
  get '/student-loans', to: 'application#student_loans'
  get '/sucuri-55d591a0065736ebad350201187df74f.php', to: 'application#sucuri_firewall'
  
  # Routes for the Plaid item resource:
  
  # CREATE ACCESS TOKEN
  get '/create_plaid_link_token', to: 'plaid_items#create_link_token'
  post '/create_plaid_access_token', to: 'plaid_items#create_access_token'
  
  # CRUD plaid_item
  resources :plaid_items, only: [:create, :index, :show, :update, :destroy]

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

  resources :loan_disbursements, only: %i[create index show update destroy]

  #------------------------------

  # Routes for the School event resource:

  resources :school_events, only: %i[create index show update destroy]

  #------------------------------

  # Routes for the Credit card resource:

  resources :credit_cards, only: %i[create index show update destroy]

  #------------------------------

  # Routes for the Loan comparison resource:

  resources :loan_comparisons, only: %i[create index show update destroy]

  #------------------------------

  # Routes for the Current loan resource:

  resources :current_loans, only: %i[create index show update destroy]

  #------------------------------

  # Routes for the Budget expense resource:

  resources :budget_expenses, only: %i[create index show update destroy]

  #------------------------------

  # Routes for the User Budget resource:

  resources :user_budgets, only: %i[create index show update destroy]

#------------------------------

  # Routes for the Cash Flow resource:

  resources :cash_flows, only: %i[create index show update destroy]

  #------------------------------

  # Routes for the Transaction resource:

  resources :transactions, only: %i[create index show update destroy]

  #------------------------------

  # Routes for the Transaction category resource:

  resources :transaction_categories, only: %i[create index show update destroy]

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
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })

end
