class UsersController < ApplicationController

  def confirm_form
    @user = User.new
  end
  
  def confirmation
    auth = session['devise.auth']
    auth.merge!(info: { email: params[:email] })
    @user = User.find_for_oauth(auth)
    if @user
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:notice] = "You don't authenticated, try again."
    end
  end
end
