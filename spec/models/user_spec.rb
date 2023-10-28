require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name and posts_counter greater than or equal to zero' do
    user = User.new(name: 'John', posts_counter: 0)
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(posts_counter: 0)
    expect(user).to_not be_valid
  end

  it 'is invalid with a negative posts_counter' do
    user = User.new(name: 'John', posts_counter: -1)
    expect(user).to_not be_valid
  end

  it 'is invalid with a non-integer posts_counter' do
    user = User.new(name: 'John', posts_counter: 1.5)
    expect(user).to_not be_valid
  end

  it 'should return three most recent posts' do
    user = User.create(name: 'John', posts_counter: 0)
    user.posts.create(title: 'Post 1', text: 'Content 1')
    post2 = user.posts.create(title: 'Post 2', text: 'Content 2')
    post3 = user.posts.create(title: 'Post 3', text: 'Content 3')
    post4 = user.posts.create(title: 'Post 4', text: 'Content 4')
    expect(user.three_most_recent_post).to eq([post4, post3, post2])
  end
end
