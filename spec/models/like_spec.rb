require 'rails_helper'

RSpec.describe Like, type: :model do
  subject do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    post = Post.create(title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0,
                       author_id: user.id)
    Like.create(post_id: post.id, author_id: user.id)
    Like.new(post_id: post.id, author_id: user.id)
  end

  before { subject.save }

  it 'should save the like' do
    expect(subject).to be_valid
  end

  it 'should update posts like counter' do
    expect(subject.post.likes_counter).to eq 2
  end
end
