class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_authorization_check

  def facebook
    load_authorization('facebook')
  end

  def twitter
    load_authorization('twitter')
  end

  private

    def load_authorization(provider)
      auth = request.env['omniauth.auth']
      @user = User.find_for_oauth(auth)
      if @user
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
      else
        redirect_to confirm_form_users_path
        session['devise.auth'] = {provider: auth.provider, uid: auth.uid}
      end
    end
end
