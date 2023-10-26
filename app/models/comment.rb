class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # Callback
  after_save :updates_comments_counter

  # Methods
  def updates_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
