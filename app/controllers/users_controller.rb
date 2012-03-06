class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:home]
  
  def home
  end

  def show
    @user = User.find(params[:id])
  end
end
