class CurrentLoansController < ApplicationController
  def index
    #matching_current_loans = CurrentLoan.all
    matching_current_loans = CurrentLoan.where({user_id: @current_user.id})

    @list_of_current_loans = matching_current_loans.order({ :created_at => :desc })

    render({ :template => "current_loans/index.html.erb" })
  end


  def show
    the_id = params.fetch("path_id")

    matching_current_loans = CurrentLoan.where({ :id => the_id })

    @the_current_loan = matching_current_loans.at(0)

    render({ :template => "current_loans/show.html.erb" })
  end

  def create
    the_current_loan = CurrentLoan.new
    the_current_loan.amount_borrowed = params.fetch("query_amount_borrowed")
    the_current_loan.amount_remaining = params.fetch("query_amount_remaining")
    the_current_loan.apr = params.fetch("query_apr")
    the_current_loan.first_payment_date = params.fetch("query_first_payment_date")
    the_current_loan.lender_name = params.fetch("query_lender_name")
    the_current_loan.loan_start_date = params.fetch("query_loan_start_date")
    the_current_loan.loan_total_cost = params.fetch("query_loan_total_cost")
    the_current_loan.monthly_payments_after_school = params.fetch("query_monthly_payments_after_school")
    the_current_loan.monthly_payments_in_school = params.fetch("query_monthly_payments_in_school")
    the_current_loan.repayment_period = params.fetch("query_repayment_period")
    the_current_loan.total_loan_amount = params.fetch("query_total_loan_amount")
    the_current_loan.user_id = params.fetch("query_user_id")

    if the_current_loan.valid?
      the_current_loan.save
      redirect_to("/current_loans", { :notice => "Current loan created successfully." })
    else
      redirect_to("/current_loans", { :alert => the_current_loan.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_current_loan = CurrentLoan.where({ :id => the_id }).at(0)

    the_current_loan.amount_borrowed = params.fetch("query_amount_borrowed")
    the_current_loan.amount_remaining = params.fetch("query_amount_remaining")
    the_current_loan.apr = params.fetch("query_apr")
    the_current_loan.first_payment_date = params.fetch("query_first_payment_date")
    the_current_loan.lender_name = params.fetch("query_lender_name")
    the_current_loan.loan_start_date = params.fetch("query_loan_start_date")
    the_current_loan.loan_total_cost = params.fetch("query_loan_total_cost")
    the_current_loan.monthly_payments_after_school = params.fetch("query_monthly_payments_after_school")
    the_current_loan.monthly_payments_in_school = params.fetch("query_monthly_payments_in_school")
    the_current_loan.repayment_period = params.fetch("query_repayment_period")
    the_current_loan.total_loan_amount = params.fetch("query_total_loan_amount")
    the_current_loan.user_id = params.fetch("query_user_id")

    if the_current_loan.valid?
      the_current_loan.save
      redirect_to("/current_loans/#{the_current_loan.id}", { :notice => "Current loan updated successfully."} )
    else
      redirect_to("/current_loans/#{the_current_loan.id}", { :alert => the_current_loan.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_current_loan = CurrentLoan.where({ :id => the_id }).at(0)

    the_current_loan.destroy

    redirect_to("/current_loans", { :notice => "Current loan deleted successfully."} )
  end
end
