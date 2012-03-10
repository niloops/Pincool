class BrandsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :show]
  before_filter :author, only: [:edit, :update]
  before_filter :admin_user, only: [:index]

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(params[:brand].merge(founder: current_user))
    if @brand.save
      current_user.follow @brand
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

  def follow_toggle
    @brand = Brand.find_by_uri params[:id]
    if @brand.followed_by? current_user
      current_user.unfollow @brand
      render "_follow_button", layout: false
    else
      current_user.follow @brand
      render "_unfollow_button", layout: false
    end
  end

  private

  def author
    @brand = Brand.find_by_uri params[:id]
    redirect_to(root_path) unless @brand && @brand.edited_by?(current_user)
  end
end
