class PostsController < ApplicationController
  before_filter :author, only: [:edit, :update, :destroy]
  
  def new
  end

  def create
  end

  def update
    @post.content = params[:content] 
    @post.photos = [Photo.new(image: params[:photo])]
    @post.save ? (redirect_to brand_post_path(@post)) : (render 'show')
  end

  def show
    @post = Post.find params[:id]
  end

  def index
  end

  def destroy
  end

  private

  def author
    @post = Post.find params[:id]
    redirect_to(root_path) unless @post && @post.edited_by?(current_user)
  end
end
