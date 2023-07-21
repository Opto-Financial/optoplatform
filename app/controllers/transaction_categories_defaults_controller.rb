class TransactionCategoriesDefaultController < ApplicationController
  def index
    matching_transaction_categories = TransactionCategoriesDefault.all

    @list_of_transaction_categories_default = matching_transaction_categories.order({ :created_at => :desc })

    render({ :template => "transaction_categories_defaults/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_transaction_categories = TransactionCategoriesDefault.where({ :id => the_id })

    @the_transaction_category_default = matching_transaction_categories.at(0)

    render({ :template => "transaction_categories_defaults/show.html.erb" })
  end

  def create
    the_transaction_category_default = TransactionCategoriesDefault.new
    the_transaction_category_default.spend_category_name = params.fetch("query_spend_category_name")
    the_transaction_category_default.spend_sub_category = params.fetch("query_spend_sub_category")
    the_transaction_category_default.spend_sub_category_details = params.fetch("query_spend_sub_category_details")

    if the_transaction_category_default.valid?
      the_transaction_category_default.save
      redirect_to("/transaction_categories_defaults", { :notice => "Transaction category created successfully." })
    else
      redirect_to("/transaction_categories_defaults", { :alert => the_transaction_category_default.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_transaction_category_default = TransactionCategoriesDefault.where({ :id => the_id }).at(0)

    the_transaction_category_default.spend_category_name = params.fetch("query_spend_category_name")
    the_transaction_category_default.spend_sub_category = params.fetch("query_spend_sub_category")
    the_transaction_category_default.spend_sub_category_details = params.fetch("query_spend_sub_category_details")

    if the_transaction_category_default.valid?
      the_transaction_category_default.save
      redirect_to("/transaction_categories_defaults/#{the_transaction_category_default.id}", { :notice => "Transaction category updated successfully."} )
    else
      redirect_to("/transaction_categories_defaults/#{the_transaction_category_default.id}", { :alert => the_transaction_category_default.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_transaction_category_default = TransactionCategoriesDefault.where({ :id => the_id }).at(0)

    the_transaction_category_default.destroy

    redirect_to("/transaction_categories_defaults", { :notice => "Transaction category deleted successfully."} )
  end
end
