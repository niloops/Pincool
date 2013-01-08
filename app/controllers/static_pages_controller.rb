class StaticPagesController < ApplicationController
  def signup
    redirect_to home_path if user_signed_in?
  end

  def upyun_redirect
    @json = {code: params[:code], message: params[:message], url: params[:url]}.to_json
    render layout: false
  end
end
