class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author).where(author: params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end
end
