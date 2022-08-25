class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.includes(:author).find(params[:post_id])

    @already_liked = Like.where(author: @user, post: @post)
    destroy && return if @already_liked.present?

    @like = Like.create(likes_params)
    @like.author = @user
    @like.post = @post

    flash[:notice] = if @like.save
                       'Successfully liked post.'
                     else
                       'Something went wrong'
                     end
    redirect_back_or_to user_post_path(@post.author, @post)
  end

  def destroy
    @like = current_user.likes.last
    @like.destroy
    @post = @like.post
    flash[:notice] = 'You unliked this post.'
    redirect_back_or_to user_post_path(@post.author, @post)
  end

  private

  def likes_params
    params.permit(:author_id, :id)
  end
end
