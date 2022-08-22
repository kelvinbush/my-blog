require 'rails_helper'

RSpec.describe 'PostsIndices', type: :system do
  before do
    driven_by(:rack_test)
    @user = User.create(name: 'Darwin', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @post = Post.create(title: 'Hello', text: 'This is my first post', author: @user)
    Comment.create(author: @user, post: @post, text: 'First comment')
    Comment.create(author: @user, post: @post, text: 'Second comment')
    Like.create(post: @post, author: @user)
  end

  it 'shows profile picture for the user' do
    visit user_posts_path(@user)
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  it 'shows the username the user' do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.name)
  end

  it 'shows number of posts for the user' do
    visit user_posts_path(@user)
    expect(page).to have_content("Number of posts: #{@user.posts_counter}")
  end

  it 'shows a post\'s title' do
    visit user_posts_path(@user)
    expect(page).to have_content(@post.title)
  end

  it 'shows a post\'s body' do
    visit user_posts_path(@user)
    expect(page).to have_content(@post.text)
  end

  it 'shows first comment on the post' do
    visit user_posts_path(@user)
    expect(page).to have_content('First comment')
  end

  it 'shows the number of comments' do
    visit user_posts_path(@user)
    expect(page).to have_content("Comments: #{@post.comments_counter}")
  end

  it 'shows the number of likes' do
    visit user_posts_path(@user)
    expect(page).to have_content("Likes: #{@post.likes_counter}")
  end

  it 'shows pagination button' do
    visit user_posts_path(@user)
    expect(page).to have_content('Pagination')
  end

  it 'should redirect to post page on post click' do
    visit user_path(@user)
    click_on @post.title
    expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
  end
end
