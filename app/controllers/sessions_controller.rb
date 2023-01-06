class SessionsController < ApplicationController
  def new
    render 'new'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password]) # if the user is successfully logged in
      if user.activated? # successful login and the user's email is activated
        reset_session
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        log_in user
        redirect_to("/")
      else # if the user's account hasn't been activated yet
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:info] = message
        redirect_to("/user_sign_in")
      end
    else # if the email/pass isn't correct
      flash[:danger] = 'Invalid email/password.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to("/home")
  end
end
