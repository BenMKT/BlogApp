class PostsController < ApplicationController
  before_action :find_user, only: [:index]
  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @targated_post = Post.find_by(id: params[:id])

    if @targated_post.nil?
      flash[:error] = 'Post not found'
      redirect_to user_posts_path(@user)
    else
      @comments = @targated_post.comments
    end
  end

  private
  
  def find_user
    @user = User.find(params[:user_id])
  end
end
