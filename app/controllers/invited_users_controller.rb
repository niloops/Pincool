class InvitedUsersController < ApplicationController
  before_filter :admin_user
  
  def new
    @invited_user = InvitedUser.new
  end

  def create
    InvitedUser.find_or_create_by(params[:invited_user])
    redirect_to invited_users_path
  end

  def destroy
    InvitedUser.find(params[:id]).destroy
    redirect_to invited_users_path
  end

  def index
    @invited_users = InvitedUser.all
  end
end
