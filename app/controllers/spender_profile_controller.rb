class SpenderProfileController < ApplicationController
  def index
    matching_spender_profiles = SpenderProfile.all

    @list_of_spender_profiles = matching_spender_profiles.order({ :created_at => :desc })

    render({ :template => "spender_profiles/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_spender_profiles = SpenderProfile.where({ :id => the_id })

    @the_spender_profile = matching_spender_profiles.at(0)

    render({ :template => "spender_profiles/show.html.erb" })
  end

  def create
    the_spender_profile = SpenderProfile.new
    the_spender_profile.user_id = params.fetch("query_user_id")
    the_spender_profile.spender_profile = params.fetch("query_spender_profile")

    if the_spender_profile.valid?
      the_spender_profile.save
      redirect_to("/spender_profiles", { :notice => "Spender Profile created successfully." })
    else
      redirect_to("/spender_profiles", { :alert => the_spender_profile.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_spender_profile = SpenderProfile.where({ :id => the_id }).at(0)

    the_spender_profile.user_id = params.fetch("query_user_id")
    the_spender_profile.spender_profile = params.fetch("query_spender_profile")

    if the_spender_profile.valid?
      the_spender_profile.save
      redirect_to("/spender_profiles/#{the_spender_profile.id}", { :notice => "Spender Profile updated successfully."} )
    else
      redirect_to("/spender_profiles/#{the_spender_profile.id}", { :alert => the_spender_profile.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_spender_profile = SpenderProfile.where({ :id => the_id }).at(0)

    the_spender_profile.destroy

    redirect_to("/spender_profiles", { :notice => "Spender Profile deleted successfully."} )
  end
end
