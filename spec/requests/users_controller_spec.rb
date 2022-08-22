require 'rails_helper'
RSpec.describe 'Users', type: :request do
  context 'when GET /index' do
    before(:example) { get users_path }

    it 'should have success code of ok' do
      expect(response).to have_http_status(:ok)
    end

    it "should render the 'index' template" do
      expect(response).to render_template(:index)
    end
  end
  context 'when GET /show' do
    let!(:user) { User.create(name: 'Darwin', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }
    before(:example) { get user_path(user.id) }

    it 'should have success code of ok' do
      expect(response).to have_http_status(:ok)
    end

    it "should render the 'show' template" do
      expect(response).to render_template(:show)
    end
  end
end
