class EvaNamesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @eva_name = EvaName.new
  end

  def create
    @eva_name = EvaName.new(params[:eva_name])
    if @eva_name.save
      redirect_to eva_names_path
    else
      render 'new'
    end
  end

  def index
    @eva_names = EvaName.all
  end

  def destroy
    EvaName.find(params[:id]).destroy
    redirect_to eva_names_path
  end
end
