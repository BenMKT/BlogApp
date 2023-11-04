class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = @post.likes.new
    @like.user = @user
    @like.save
    redirect_to user_post_path(@user, @post)
  end
end
