class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author, :comments).where(author: params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @user = Current.user
    @post = Post.create(post_params)
    @post.author = @user
    if @post.save
      flash[:notice] = 'New post created successfully.'
      redirect_to user_post_path(@user, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
