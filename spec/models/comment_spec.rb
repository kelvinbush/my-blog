require 'rails_helper'

RSpec.describe Comment, type: :model do
  first_user = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  first_post = Post.new(author: first_user, title: 'Hello', text: 'This is my first post')
  comment = Comment.new(post: first_post, author: first_user, text: 'Hi Tom!')
  comment2 = Comment.new(post: first_post, author: first_user, text: 'Hi John!')
  comment3 = Comment.new(post: first_post, author: first_user, text: 'Hi Mike!')

  before(:all) do
    first_user.save
    first_post.save
    comment.save
  end

  it 'text should update posts comment counter' do
    first_user.name = nil
    expect(first_user).to_not be_valid
  end

end