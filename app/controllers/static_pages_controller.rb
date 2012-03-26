class StaticPagesController < ApplicationController
  def signup
    redirect_to home_path if signed_in?
    @invited_user = InvitedUser.find_by_provider_and_name(params[:provider], params[:name])
  end

  def upyun_redirect
    @json = {code: params[:code], message: params[:message], url: params[:url]}.to_json
    render layout: false
  end
end
