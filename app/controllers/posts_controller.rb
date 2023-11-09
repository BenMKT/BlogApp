class PostsController < ApplicationController
  before_action :find_user, only: %i[index show]
  def index
    @posts = @user.posts.includes(:comments).paginate(page: params[:page])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(post_params)
    if @post.save
      redirect_to user_posts_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
