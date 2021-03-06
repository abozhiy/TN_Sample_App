class UsersController < ApplicationController
  skip_authorization_check

  def confirm_form
    @user = User.new
  end
  
  def confirmation
    auth = session['devise.auth']
    auth.merge!(info: { email: params[:email] })
    @user = User.find_for_oauth(OmniAuth::AuthHash.new(auth))
    if @user
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:notice] = "You don't authenticated, try again."
    end
  end
end
