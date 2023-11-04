class CommentsController < ApplicationController
  before_action :find_post, only: %i[new create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      render 'new'
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
