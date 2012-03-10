class SessionsController < ApplicationController
  def create
    auth = Authentication.build_with_omniauth(request.env["omniauth.auth"])
    redirect_to root_path unless auth && auth.valid?
    user = User.find_by_auth(auth)
    user && (user.current_auth = auth) && (return sign_in_with_redirect(user))
    #current_user && current_user.add_auth(auth) && (redirect_to add_auth_path)
    #begin register guide
    InvitedUser.find_by_provider_and_name(auth.provider, auth.name) ?
    (sign_in_with_redirect User.create_with_auth(auth)) :
      (redirect_to root_path)
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def sign_in_with_redirect(user)
    sign_in user
    redirect_to home_path
  end
end
