require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject do
    first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                             bio: 'Teacher from Mexico.', posts_counter: 0)
    first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                             likes_counter: 0)
    Comment.create(post: first_post, author: first_user, text: 'Hi Tom!')
    Comment.create(post: first_post, author: first_user, text: 'Hi John!')
    Comment.new(post: first_post, author: first_user, text: 'Hi Mike!')
  end

  before { subject.save }

  it 'should save a comment' do
    expect(subject).to be_valid
  end

  it 'should update comment counter' do
    expect(subject.post.comments_counter).to eq 3
  end
end
