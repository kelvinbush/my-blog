require "rails_helper"

RSpec.describe 'PostShows', type: :system do
  before do
    driven_by(:rack_test)
    @user = User.create(name: 'Darwin', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @user2 = User.create(name: 'Ken', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @post = Post.create(title: 'Hello', text: 'This is my first post', author: @user)
    Comment.create(author: @user, post: @post, text: 'First comment')
    Comment.create(author: @user2, post: @post, text: 'Second comment')
    Like.create(post: @post, author: @user)
  end

  it 'shows a post\'s title' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.title)
  end

  it 'shows the post author' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@user.name)
  end

  it 'shows the number of comments' do
    visit user_post_path(@user, @post)
    expect(page).to have_content("Comments: #{@post.comments_counter}")
  end

  it 'shows the number of likes' do
    visit user_post_path(@user, @post)
    expect(page).to have_content("Likes: #{@post.likes_counter}")
  end

  it 'shows a post\'s body' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.text)
  end

  it 'shows username of each comment author' do
    visit user_post_path(@user, @post)
    comment = @post.comments.first
    expect(page).to have_content(comment.author.name)
  end

  it 'shows the comment each comment author left' do
    visit user_post_path(@user, @post)
    comment = @post.comments.first
    comment2 = @post.comments.last
    expect(page).to have_content(comment.text)
    expect(page).to have_content(comment2.text)
  end
end
