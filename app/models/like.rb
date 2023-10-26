class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Callback
  after_save :updates_post_likes_counter

  # Methods
  def updates_post_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
