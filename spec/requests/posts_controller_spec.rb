require 'rails_helper'
RSpec.describe 'Posts', type: :request do
  let!(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let!(:post) do
    Post.create(author: user, title: 'Hello', text: 'This is my first post')
  end

  context 'when GET /index' do
    before { @posts = post }
    before(:example) { get user_posts_path(user.id) }

    it 'should have success code of ok' do
      expect(response).to have_http_status(:ok)
    end

    it "should render the 'index' template" do
      expect(response).to render_template(:index)
    end
  end
  context 'when GET /show' do
    before(:example) { get user_post_path(user, post) }

    it 'should have success code of ok' do
      expect(response).to have_http_status(:ok)
    end

    it "should render the 'show' template" do
      expect(response).to render_template(:show)
    end
  end
end
