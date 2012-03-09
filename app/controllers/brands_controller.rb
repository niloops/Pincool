class BrandsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create]
  before_filter :author, only: [:edit, :update]
  before_filter :admin_user, only: [:index]

  def new
    @brand = Brand.new
  end

  def create
    @brand = current_user.brands.build(params[:brand])
    if @brand.save
      redirect_to @brand
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @brand.update_attributes(params[:brand]) ?
    (redirect_to @brand) :
      (render 'edit')
  end

  def show
    @brand = Brand.find_by_uri params[:id]
  end

  def index
    @brands = Brand.desc(:created_at).page params[:page]
  end

  private

  def author
    @brand = Brand.find_by_uri params[:id]
    redirect_to(root_path) unless @brand && @brand.edited_by?(current_user)
  end
end
