class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author, :comments).where(author: params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end
end
