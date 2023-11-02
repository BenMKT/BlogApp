require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with content and a post_id' do
    user = User.create(name: 'John')
    post = Post.create(title: 'Test Post', comments_counter: 0, likes_counter: 0, author_id: user.id)
    comment = Comment.new(text: 'Test comment', post_id: post.id, user_id: user.id)
    expect(comment).to be_valid
  end

  it 'is invalid without content' do
    user = User.create(name: 'John')
    post = Post.create(title: 'Test Post', comments_counter: 0, likes_counter: 0, author_id: user.id)
    comment = Comment.new(post_id: post.id, user_id: user.id)
    expect(comment).to_not be_valid
  end

  it 'is invalid with too long content' do
    user = User.create(name: 'John')
    post = Post.create(title: 'Test Post', comments_counter: 0, likes_counter: 0, author_id: user.id)
    comment = Comment.new(text: 'A' * 1001, post_id: post.id, user_id: user.id)
    expect(comment).to_not be_valid
  end

  it 'is invalid without a post_id' do
    user = User.create(name: 'John')
    comment = Comment.new(text: 'Test comment', user_id: user.id)
    expect(comment).to_not be_valid
  end

  it 'updates the post\'s comments_counter when a comment is saved' do
    user = User.create(name: 'John')
    post = Post.create(title: 'Test Post', comments_counter: 0, likes_counter: 0, author_id: user.id)
    comment = Comment.new(text: 'Test comment', post_id: post.id, user_id: user.id)
    expect do
      comment.save
      post.reload
    end.to change(post, :comments_counter).by(1)
  end
end
