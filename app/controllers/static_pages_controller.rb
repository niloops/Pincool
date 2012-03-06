class StaticPagesController < ApplicationController
  def signup
    redirect_to home_path if signed_in?
    @invited_user = InvitedUser.find_by_provider_and_name(params[:provider], params[:name])
  end
end
