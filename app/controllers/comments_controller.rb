class CommentsController < ApplicationController
  before_filter :signed_in_user
  
  def create
    post = Post.find params[:post_id]
    @comment = Comment.new(author: current_user,
                          content: params[:content].strip)
    (post.comments << @comment) ?
    (render "comment", layout: false) :
      (render nothing: true, status: 204)
  end

  def destroy
    post = Post.find params[:post_id]
    comment = post.comments.find params[:id]
    if comment.editable_by?(current_user)
      comment.destroy
      render text: "success"
    else
      render nothing: true, status: 403
    end
  end
end
