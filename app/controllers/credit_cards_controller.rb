class CreditCardsController < ApplicationController
  def index
    #matching_credit_cards = CreditCard.all
    matching_credit_cards = CreditCard.where({user_id: @current_user.id})

    @list_of_credit_cards = matching_credit_cards.order({ :created_at => :desc })

    render({ :template => "credit_cards/index.html.erb" })
  end


  def show
    the_id = params.fetch("path_id")

    matching_credit_cards = CreditCard.where({ :id => the_id })

    @the_credit_card = matching_credit_cards.at(0)

    render({ :template => "credit_cards/show.html.erb" })
  end

  def create
    the_credit_card = CreditCard.new
    the_credit_card.apr = params.fetch("query_apr")
    the_credit_card.card_name = params.fetch("query_card_name")
    the_credit_card.credit_line = params.fetch("query_credit_line")
    the_credit_card.current_balance = params.fetch("query_current_balance")
    the_credit_card.minimum_payment = params.fetch("query_minimum_payment")
    the_credit_card.payment_date = params.fetch("query_payment_date")
    the_credit_card.statement_start_date = params.fetch("query_statement_start_date")
    the_credit_card.plaid_account_id = params.fetch("query_plaid_account_id")
    the_credit_card.account_id = params.fetch("query_account_id")

    if the_credit_card.valid?
      the_credit_card.save
      redirect_to("/credit_cards", { :notice => "Credit card created successfully." })
    else
      redirect_to("/credit_cards", { :alert => the_credit_card.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_credit_card = CreditCard.where({ :id => the_id }).at(0)

    the_credit_card.apr = params.fetch("query_apr")
    the_credit_card.card_name = params.fetch("query_card_name")
    the_credit_card.credit_line = params.fetch("query_credit_line")
    the_credit_card.current_balance = params.fetch("query_current_balance")
    the_credit_card.minimum_payment = params.fetch("query_minimum_payment")
    the_credit_card.payment_date = params.fetch("query_payment_date")
    the_credit_card.statement_start_date = params.fetch("query_statement_start_date")
    the_credit_card.plaid_account_id = params.fetch("query_plaid_account_id")
    the_credit_card.account_id = params.fetch("query_account_id")

    if the_credit_card.valid?
      the_credit_card.save
      redirect_to("/credit_cards/#{the_credit_card.id}", { :notice => "Credit card updated successfully."} )
    else
      redirect_to("/credit_cards/#{the_credit_card.id}", { :alert => the_credit_card.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_credit_card = CreditCard.where({ :id => the_id }).at(0)

    the_credit_card.destroy

    redirect_to("/credit_cards", { :notice => "Credit card deleted successfully."} )
  end
end
