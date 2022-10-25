class BudgetIncomesController < ApplicationController
  def index
    matching_budget_incomes = BudgetIncome.all

    @list_of_budget_incomes = matching_budget_incomes.order({ :created_at => :desc })

    render({ :template => "budget_incomes/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_budget_incomes = BudgetIncome.where({ :id => the_id })

    @the_budget_income = matching_budget_incomes.at(0)

    render({ :template => "budget_incomes/show.html.erb" })
  end

  def create
    the_budget_income = BudgetIncome.new
    the_budget_income.income_name = params.fetch("query_income_name")
    the_budget_income.income_amount = params.fetch("query_income_amount")
    the_budget_income.income_category_id = params.fetch("query_income_category_id")
    the_budget_income.first_recurrence_date = params.fetch("query_first_recurrence_date")
    the_budget_income.recurring_frequency = params.fetch("query_recurring_frequency")
    the_budget_income.user_id = params.fetch("query_user_id")

    if the_budget_income.valid?
      the_budget_income.save

      UserBudget.where({user_id: @current_user.id}).where("first_day_of_month <= ?", the_budget_income.first_recurrence_date).where("last_day_of_month >= ?", the_budget_income.first_recurrence_date).first.update(:total_income=> BudgetIncome.where({user_id: @current_user.id}).by_month(the_budget_income.first_recurrence_date.year, the_budget_income.first_recurrence_date.strftime("%B")).sum(:income_amount))

      CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date).where("last_day_of_week >= ?", the_budget_income.first_recurrence_date).first.update(:remaining_cash => (
      (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date).where("last_day_of_week >= ?", the_budget_income.first_recurrence_date).pluck(:remaining_cash).first).to_f + (the_budget_income.income_amount).to_f))

      cash_flow_order_1 = CashFlow.where({user_id: @current_user.id}).where("first_day_of_week > ?", the_budget_income.first_recurrence_date)

      @cash_flow_order_2 = cash_flow_order_1.order({ :first_day_of_week => :asc })

      for a_cash_flow in @cash_flow_order_2 do

        @new_min_date = a_cash_flow.first_day_of_week

        @new_max_date = a_cash_flow.last_day_of_week

        a_cash_flow.update(:remaining_cash =>
          (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week = ?", a_cash_flow.first_day_of_week - 7).where("last_day_of_week = ?", a_cash_flow.last_day_of_week - 7).pluck(:remaining_cash).first.to_f - 
            BudgetExpense.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:expense_amount) +
            BudgetIncome.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:income_amount)
              )
        )

      end

      redirect_to("/budget_expenses", { :notice => "Budget income created successfully." })
    else
      redirect_to("/budget_expenses", { :alert => the_budget_income.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_budget_income = BudgetIncome.where({ :id => the_id }).at(0)

    the_budget_income.income_name = params.fetch("query_income_name")
    the_budget_income.income_amount = params.fetch("query_income_amount")
    #the_budget_income.income_category_id = params.fetch("query_income_category_id")
    the_budget_income.income_category_id =
    (if params.fetch("query_income_category_id") == "Select One"
      the_budget_income.income_category_id = the_budget_income.income_category_id
    else the_budget_income.income_category_id = params.fetch("query_income_category_id")
    end)
    the_budget_income.first_recurrence_date = params.fetch("query_first_recurrence_date")
    #the_budget_income.recurring_frequency = params.fetch("query_recurring_frequency")
    the_budget_income.recurring_frequency = 
    (if params.fetch("query_recurring_frequency") == "Select One"
        the_budget_income.recurring_frequency = the_budget_income.recurring_frequency
      else the_budget_income.recurring_frequency = params.fetch("query_recurring_frequency")
      end)
    #the_budget_income.user_id = params.fetch("query_user_id")
    the_budget_income.user_id = @current_user.id 

    if the_budget_income.valid?
      the_budget_income.save

      # UserBudget.where({user_id: @current_user.id}).where("first_day_of_month <= ?", the_budget_income.first_recurrence_date).where("last_day_of_month >= ?", the_budget_income.first_recurrence_date).first.update(:total_income=> BudgetIncome.where({user_id: @current_user.id}).by_month(the_budget_income.first_recurrence_date.year, the_budget_income.first_recurrence_date.strftime("%B")).sum(:income_amount))


      for any_user_budget in UserBudget.where({user_id: @current_user.id}) do
        
        @any_user_budget_first_day = any_user_budget.first_day_of_month

        any_user_budget.update(:total_income=> BudgetIncome.where({user_id: @current_user.id}).by_month(@any_user_budget_first_day.year, @any_user_budget_first_day.strftime("%B")).sum(:income_amount))

        any_user_budget.update(:total_expenses=> BudgetExpense.where({user_id: @current_user.id}).by_month(@any_user_budget_first_day.year, @any_user_budget_first_day.strftime("%B")).sum(:expense_amount))
      
      end

      @min_date = CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date).where("last_day_of_week >= ?", the_budget_income.first_recurrence_date).pluck(:first_day_of_week).first

      @max_date = CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date).where("last_day_of_week >= ?", the_budget_income.first_recurrence_date).pluck(:last_day_of_week).first

      CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date).where("last_day_of_week >= ?", the_budget_income.first_recurrence_date).first.update(:remaining_cash => (
            CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date - 7).where("last_day_of_week >= ?", the_budget_income.first_recurrence_date - 7).pluck(:remaining_cash).first - 
            BudgetExpense.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @max_date).where("first_recurrence_date >= ?", @min_date).sum(:expense_amount) +
            BudgetIncome.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @max_date).where("first_recurrence_date >= ?", @min_date).sum(:income_amount)
                  )
              )

      
      cash_flow_order_3 = CashFlow.where({user_id: @current_user.id}).where("first_day_of_week > ?", "2022-10-23")

      @cash_flow_order_4 = cash_flow_order_3.order({ :first_day_of_week => :asc })
        
      for a_cash_flow in @cash_flow_order_4 do

          @new_min_date = a_cash_flow.first_day_of_week

          @new_max_date = a_cash_flow.last_day_of_week

          a_cash_flow.update(:remaining_cash =>
            (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week = ?", a_cash_flow.first_day_of_week - 7).where("last_day_of_week = ?", a_cash_flow.last_day_of_week - 7).pluck(:remaining_cash).first.to_f - 
              BudgetExpense.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:expense_amount) +
              BudgetIncome.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:income_amount)
                )
          )
        
      end

      redirect_to("/budget_expenses")
      #, { :notice => "Budget income updated successfully."} )
    else
      redirect_to("/budget_incomes/#{the_budget_income.id}", { :alert => the_budget_income.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_budget_income = BudgetIncome.where({ :id => the_id }).at(0)

    UserBudget.where({user_id: @current_user.id}).where("first_day_of_month <= ?", the_budget_income.first_recurrence_date).where("last_day_of_month >= ?", the_budget_income.first_recurrence_date).first.update(:total_income=> 
    ((BudgetIncome.where({user_id: @current_user.id}).by_month(the_budget_income.first_recurrence_date.year, the_budget_income.first_recurrence_date.strftime("%B")).sum(:income_amount) ) - the_budget_income.income_amount)
    )

    CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date).where("last_day_of_week >= ?", the_budget_income.first_recurrence_date).first.update(:remaining_cash => (
      (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week <= ?", the_budget_income.first_recurrence_date).where("last_day_of_week >= ?", the_budget_income.first_recurrence_date).pluck(:remaining_cash).first).to_f - (the_budget_income.income_amount).to_f))

      cash_flow_order_5 = CashFlow.where({user_id: @current_user.id}).where("first_day_of_week > ?", "2022-10-23")

      @cash_flow_order_6 = cash_flow_order_5.order({ :first_day_of_week => :asc })
                
      for a_cash_flow in @cash_flow_order_6 do

        @new_min_date = a_cash_flow.first_day_of_week

        @new_max_date = a_cash_flow.last_day_of_week

        a_cash_flow.update(:remaining_cash =>
          (CashFlow.where({user_id: @current_user.id}).where("first_day_of_week = ?", a_cash_flow.first_day_of_week - 7).where("last_day_of_week = ?", a_cash_flow.last_day_of_week - 7).pluck(:remaining_cash).first.to_f - 
            BudgetExpense.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:expense_amount) +
            BudgetIncome.where({user_id: @current_user.id}).where("first_recurrence_date <= ?", @new_max_date).where("first_recurrence_date >= ?", @new_min_date).sum(:income_amount)
              )
        )
      
    end

    the_budget_income.destroy

    redirect_to("/budget_expenses")
    #, { :notice => "Budget income deleted successfully."} )
  end
end
