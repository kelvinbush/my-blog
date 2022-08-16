require 'rails_helper'
RSpec.describe 'Users', type: :request do
  context 'when GET /index' do
    before(:example) { get users_path }

    it 'should have success code of 200' do
      expect(response).to have_http_status(:ok)
    end

    it "should render the 'index' template" do
      expect(response).to render_template(:index)
    end

    it 'should display correct content in the views' do
      expect(response.body).to include('Here is a list of users')
    end
  end
end