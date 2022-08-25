class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user!

  include Response

  def list_all_user_posts
    authentication_token = params[:authentication_token]
    return unless check_token_user_params(authentication_token)

    posts = Post.where(author_id: params[:user_id])
    json_response(posts)
  end

  def add_comment
    authentication_token = params[:authentication_token]
    return unless check_token_user_params(authentication_token)

    post_id = params[:post_id]
    text = params[:text]
    return unless check_post_comment_params(text)

    comment = Comment.new(text:, author: @current_user, post_id:)
    if comment.save
      json_response(comment, 200)
    else
      json_response({ error: 'Comment was not created, please try again later.' }, 500)
    end
  end

  def list_comments
    authentication_token = params[:authentication_token]
    return unless check_token_user_params(authentication_token)

    return unless check_post_params

    comments = Comment.where(post_id: params[:post_id], author_id: params[:user_id])
    json_response(comments)
  end
end
