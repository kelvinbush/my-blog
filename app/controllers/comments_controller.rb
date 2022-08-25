class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = Comment.create(comment_params)
    @comment.post = post
    @comment.author = current_user
    if @comment.save
      flash[:notice] = 'Comment added successfully.'
      redirect_to user_post_path(post.author, post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(current_user, params[:post_id]), notice: 'Successfully removed the comment.'
  end

  private

  def comment_params
    params.permit(:text)
  end
end
