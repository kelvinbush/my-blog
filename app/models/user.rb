class User < ApplicationRecord
  has_many :comments, foreign_key: :author_id
  has_many :posts, foreign_key: :author_id

  def last_three_posts
    posts.includes(:author).order(created_at: :desc).limit(3)
  end
end
