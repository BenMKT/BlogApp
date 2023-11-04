class LikesController < ApplicationController
  before_action :find_post, only: [:create]

  def create
    @like = current_user.likes.build(post: @post)

    if @like.save
      redirect_to @post, notice: 'Liked the post!'
    else
      redirect_to @post, alert: 'Failed to like the post.'
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy

    redirect_to @like.post, notice: 'Unliked the post.'
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
