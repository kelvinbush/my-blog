require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }

  before { subject.save }

  it 'should save the user' do
    expect(subject).to be_valid
  end

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have equal to or greater than 0 post counter' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end

  it 'should get the last 3 posts' do
    Post.create(title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0, author: subject)
    Post.create(title: 'Hello2', text: 'This is my second post', comments_counter: 0, likes_counter: 0, author: subject)
    Post.create(title: 'Hello3', text: 'This is my third post', comments_counter: 0, likes_counter: 0, author: subject)
    Post.create(title: 'Hello4', text: 'This is my fourth post', comments_counter: 0, likes_counter: 0, author: subject)
    expect(subject.last_three_posts.length).to eq 3
    expect(subject.last_three_posts[0].text).to eq 'This is my fourth post'
  end
end
