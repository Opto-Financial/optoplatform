class UserBudgetsController < ApplicationController

  def index
    matching_user_budgets = UserBudget.where({user_id: @current_user.id})

    @list_of_user_budgets = matching_user_budgets.order({ :first_day_of_month => :asc })

    render({ :template => "budget_expenses/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_user_budgets = UserBudget.where({ :id => the_id })

    @the_user_budget = matching_user_budgets.at(0)

    render({ :template => "user_budgets/show.html.erb" })
  end

  def create
    the_user_budget = UserBudget.new
    
    the_user_budget.user_id = params.fetch("query_user_id")
    the_user_budget.first_day_of_month = params.fetch("query_first_day_of_month")
    the_user_budget.last_day_of_month = params.fetch("query_last_day_of_month")
    the_user_budget.total_expenses = params.fetch("query_total_expenses")
    the_user_budget.total_income = params.fetch("query_total_income")

    if the_user_budget.valid?
      the_user_budget.save
      redirect_to("/budget_expenses")
      # , { :notice => "User budget created successfully." })
    else
      redirect_to("/budget_expenses", { :alert => the_user_budget.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_user_budget = UserBudget.where({ :id => the_id }).at(0)

    the_user_budget.user_id = @current_user.id
    the_user_budget.first_day_of_month = params.fetch("query_first_day_of_month")
    the_user_budget.last_day_of_month = params.fetch("query_last_day_of_month")
    the_user_budget.total_expenses = params.fetch("query_total_expenses")
    the_user_budget.total_income = params.fetch("query_total_income")

    if the_user_budget.valid?
      the_user_budget.save
      redirect_to("/budget_expenses")
      # , { :notice => "User budget updated successfully."} )
    else
      redirect_to("/budget_expenses/", { :alert => the_user_budget.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_user_budget = UserBudget.where({ :id => the_id }).at(0)

    the_user_budget.destroy

    redirect_to("/budget_expenses")
    # , { :notice => "User budget deleted successfully."} )
  end

end
