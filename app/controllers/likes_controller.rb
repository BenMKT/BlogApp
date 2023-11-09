class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = @post.likes.new
    @like.user = @user
    @like.save
    redirect_to user_post_path(@user, @post)
  end
end
