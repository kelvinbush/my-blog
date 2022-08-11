require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 3) }

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

end
