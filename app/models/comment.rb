class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # Validations
  validates :post_id, presence: true
  validates :text, presence: true, length: { maximum: 1000 }

  # Callback
  after_save :updates_comments_counter

  # Methods
  private

  def updates_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
