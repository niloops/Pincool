class PostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :author, only: [:edit, :update, :destroy]
  before_filter :build_post, only: [:new, :create]

  def new
    render 'show'
  end

  def create
    return save_post
  end

  def update
    return save_post
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

  def build_post
    brand = Brand.find_by_uri params[:brand_id]
    @post = Post.get_class(params[:type])
      .new(author: current_user,brand: brand)
  end

  def save_post
    @post.evas = [1,2,3] if @post.respond_to? :evas
    
    @post.content = params[:content]
    @post.photos = [Photo.new(image: params[:photo])] if params[:photo]
    @post.title = params[:title] if @post.respond_to? :title
    @post.save ? (redirect_to brand_post_path(@post.brand, @post)) : (render 'show')
  end

  def author
    @post = Post.find params[:id]
    redirect_to(root_path) unless @post && @post.edited_by?(current_user)
  end
end
