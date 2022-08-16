require 'rails_helper'
RSpec.describe 'Posts', type: :request do
  context 'when GET /index' do
    before(:example) { get user_posts_path(1) }

    it 'should have success code of 200' do
      expect(response).to have_http_status(:ok)
    end

    it "should render the 'index' template" do
      expect(response).to render_template(:index)
    end

    it 'should display correct content in the views' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end
  context 'when GET /show' do
    before(:example) { get user_post_path(1, 1) }

    it 'should have success code of 200' do
      expect(response).to have_http_status(:ok)
    end

    it "should render the 'show' template" do
      expect(response).to render_template(:show)
    end

    it 'should display correct content in the views' do
      expect(response.body).to include('A post  based on the post id')
    end
  end
end