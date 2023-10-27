require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with content and a post_id' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.create(title: 'Test Post', comments_counter: 0, likes_counter: 0, author_id: user.id)
    comment = Comment.new(text: 'Test comment', post: post, user_id: user.id)
    expect(comment).to be_valid
  end

  it 'is invalid without content' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.create(title: 'Test Post', comments_counter: 0, likes_counter: 0, author_id: user.id)
    comment = Comment.new(post: post, user_id: user.id)
    expect(comment).to_not be_valid
  end

  it 'is invalid with too long content' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.create(title: 'Test Post', comments_counter: 0, likes_counter: 0, author_id: user.id)
    comment = Comment.new(text: 'A' * 1001, post: post, user_id: user.id)
    expect(comment).to_not be_valid
  end

  it 'is invalid without a post_id' do
    user = User.create(name: 'John', posts_counter: 0)
    comment = Comment.new(text: 'Test comment', user_id: user.id)
    expect(comment).to_not be_valid
  end
end
