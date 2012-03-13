class PostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :author, only: [:edit, :update, :destroy]

  def new
    brand = Brand.find_by_uri params[:brand_id]
    @post = Post.get_class(params[:type] || "feeling")
      .new(author: current_user, brand: brand)
    render 'show'
  end

  def create
    brand = Brand.find_by_uri params[:brand_id]
    @post = Post.get_class(params[:type])
      .new(author: current_user,
           brand: brand,
           photos: [Photo.new(image: params[:photo])],
           content: params[:content])
    @post.save ? (redirect_to brand_post_path(brand, @post)) : (render 'show')
  end

  def update
    @post.content = params[:content]
    @post.photos = [Photo.new(image: params[:photo])]
    @post.save ? (redirect_to brand_post_path(@post.brand, @post)) : (render 'show')
  end

  def show
    @post = Post.find params[:id]
  end

  def index
  end

  def destroy
    brand = @post.brand
    @post.destroy
    redirect_to brand_path(brand)
  end

  private

  def author
    @post = Post.find params[:id]
    redirect_to(root_path) unless @post && @post.edited_by?(current_user)
  end
end
