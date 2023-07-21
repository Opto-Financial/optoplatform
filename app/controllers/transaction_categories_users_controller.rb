class TransactionCategoriesUserController < ApplicationController
  def index
    matching_transaction_categories = TransactionCategoriesUser.where({user_id: @current_user.id})

    @list_of_transaction_categories_users = matching_transaction_categories.order({ :created_at => :desc })

    render({ :template => "transaction_categories_users/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_transaction_categories = TransactionCategoriesUser.where({ :id => the_id })

    @the_transaction_category_user = matching_transaction_categories.at(0)

    render({ :template => "transaction_categories_users/show.html.erb" })
  end

  def create
    the_transaction_category_user = TransactionCategoriesUser.new
    the_transaction_category_user.spend_category_name = params.fetch("query_spend_category_name")
    the_transaction_category_user.user_id = params.fetch("query_user_id")
    the_transaction_category_user.spend_sub_category = params.fetch("query_spend_sub_category")
    the_transaction_category_user.spend_sub_category_details = params.fetch("query_spend_sub_category_details")

    if the_transaction_category_user.valid?
      the_transaction_category_user.save
      redirect_to("/transaction_categories_users", { :notice => "Transaction category created successfully." })
    else
      redirect_to("/transaction_categories_users", { :alert => the_transaction_category_user.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_transaction_category_user = TransactionCategoriesUser.where({ :id => the_id }).at(0)

    the_transaction_category_user.spend_category_name = params.fetch("query_spend_category_name")
    the_transaction_category_user.user_id = params.fetch("query_user_id")
    the_transaction_category_user.spend_sub_category = params.fetch("query_spend_sub_category")
    the_transaction_category_user.spend_sub_category_details = params.fetch("query_spend_sub_category_details")

    if the_transaction_category_user.valid?
      the_transaction_category_user.save
      redirect_to("/transaction_categories_users/#{the_transaction_category_user.id}", { :notice => "Transaction category updated successfully."} )
    else
      redirect_to("/transaction_categories_users/#{the_transaction_category_user.id}", { :alert => the_transaction_category_user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_transaction_category_user = TransactionCategoriesUser.where({ :id => the_id }).at(0)

    the_transaction_category_user.destroy

    redirect_to("/transaction_categories_users", { :notice => "Transaction category deleted successfully."} )
  end
end
