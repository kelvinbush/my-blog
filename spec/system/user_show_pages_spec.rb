require 'rails_helper'

RSpec.describe 'UserShowPages', type: :system do
  before do
    driven_by(:rack_test)
    @user = User.create(name: 'Darwin', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    Post.create(title: 'Hello', text: 'This is my first post', author: @user)
    Post.create(title: 'Hello2', text: 'This is my second post', author: @user)
    Post.create(title: 'Hello3', text: 'This is my first post', author: @user)
    Post.create(title: 'Hello4', text: 'This is my second post', author: @user)
  end

  it 'shows user profile picture' do
    visit user_path(@user)
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  it 'shows the username the user' do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  it 'shows number of posts for the user' do
    visit user_path(@user)
    expect(page).to have_content("Number of posts: #{@user.posts_counter}")
  end

  it "shows the user's bio" do
    visit user_path(@user)
    expect(page).to have_content(@user.bio)
  end

  it 'shows user\'s last 3 posts' do
    visit user_path(@user)
    last_three_posts = @user.last_three_posts
    expect(page).to have_content(last_three_posts[0].title)
    expect(page).to have_content(last_three_posts[1].title)
    expect(page).to have_content(last_three_posts[2].title)
  end

  it 'shows view all user posts button' do
    visit user_path(@user)
    expect(page).to have_selector(:link_or_button, 'See all posts', count: 1)
  end

  it 'should redirect to post page on post click' do
    visit user_path(@user)
    post = @user.last_three_posts[0]
    click_on post.title
    expect(page).to have_current_path(user_post_path(user_id: @user.id, id: post.id))
  end

  it 'should redirect to posts index page on sea all posts click' do
    visit user_path(@user)
    click_on 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
