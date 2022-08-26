class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable, :confirmable

  has_many :comments, foreign_key: :author_id
  has_many :posts, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  def admin?
    role == 'admin'
  end

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  after_save :add_token

  def add_token
    update_column(:authentication_token, ApiHelper::JsonWebToken.encode(email))
  end

  def last_three_posts
    posts.includes(:author).order(created_at: :desc).limit(3)
  end
end
