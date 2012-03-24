class UsersController < ApplicationController
  before_filter :signed_in_user
  
  def home
    if current_user.followings.blank? || params[:recommend]
      @categories = Category.limit(10)
      render 'recommends'
    end
  end

  def follow_posts_data
    @posts = current_user.follow_posts.by_type(params[:type]).page(params[:page])
    render 'shared/posts', layout: false
  end

  def show
    @user = User.find(params[:id])
  end

  def followings
    @user = User.find(params[:id])
    @brands = @user.followings
    render layout: false
  end

  def found_brands
    @user = User.find(params[:id])
    @brands = @user.found_brands
    render "followings", layout: false
  end

  def pub_posts
    @user = User.find(params[:id])
    render layout: false
  end

  def pub_posts_data
    @user = User.find(params[:id])
    @posts = @user.posts.by_type(params[:type]).page(params[:page])
    render 'shared/posts', layout: false
  end
end
