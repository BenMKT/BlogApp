require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is invalid without a title' do
    post = Post.new(comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is invalid with a long title' do
    post = Post.new(title: 'A' * 251, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is invalid with a negative comments_counter' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.new(title: 'Test Post', comments_counter: -1, likes_counter: 0, author_id: user.id)
    expect(post).to_not be_valid
  end

  it 'is invalid with a non-integer likes_counter' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.new(title: 'Test Post', comments_counter: 0, likes_counter: 1.5, author_id: user.id)
    expect(post).to_not be_valid
  end

  it 'increments the author\'s posts_counter when a post is saved' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.new(title: 'Test Post', comments_counter: 0, likes_counter: 0, author_id: user.id)
    expect do
      post.save
      user.reload
    end.to change(user, :posts_counter).by(1)
  end

  it 'returns the most recent comments limited by the specified limit' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.new(title: 'Test Post', comments_counter: 0, likes_counter: 0, author_id: user.id)
    post.save!
    comments = []
    (1..10).each do |i|
      comment = Comment.create!(text: "Comment #{i}", user_id: user.id, post_id: post.id)
      comments << comment
    end

    five_most_recent_comments = post.five_most_recent_comments
    expect(five_most_recent_comments.to_a).to eq(comments.last(5).reverse)
  end
end
