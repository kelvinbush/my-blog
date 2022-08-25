class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.includes(:author, :comments).where(author: params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = @user.posts.new
  end

  def create
    @user = current_user
    @post = @user.posts.create(post_params)
    if @post.save
      flash[:notice] = 'New post created successfully.'
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:alert] = 'Post creation failed'
      render action: 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@post.author), notice: "Successfully deleted the post #{@post.title}."
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
