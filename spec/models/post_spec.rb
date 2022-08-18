require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    Post.create(title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0, author: user)
    Post.create(title: 'Hello2', text: 'This is my second post', comments_counter: 0, likes_counter: 0, author: user)
    Post.new(title: 'Hello3', text: 'This is my third post', comments_counter: 0, likes_counter: 0, author: user)
  end

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'comment counter should be greater or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes counter should be greater or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should update posts counter' do
    expect(subject.author.posts_counter).to eq 3
  end

  it 'should get last 5 comment' do
    Comment.create(post: subject, author: subject.author, text: 'Hi John!')
    Comment.create(post: subject, author: subject.author, text: 'Hi John!2')
    Comment.create(post: subject, author: subject.author, text: 'Hi John!3')
    Comment.create(post: subject, author: subject.author, text: 'Hi John!4')
    Comment.create(post: subject, author: subject.author, text: 'Hi John!5')
    Comment.create(post: subject, author: subject.author, text: 'Hi John!6')
    Comment.create(post: subject, author: subject.author, text: 'Hi John!7')
    expect(subject.last_five_comments.length).to eq 5
    expect(subject.last_five_comments[0].text).to eq 'Hi John!7'
  end
end
