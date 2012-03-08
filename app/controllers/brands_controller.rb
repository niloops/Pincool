class BrandsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create]
  
  def new
    @brand = Brand.new
  end

  def create
    
  end

  def edit
  end

  def update
  end

  def show
  end

  def index
  end
end
