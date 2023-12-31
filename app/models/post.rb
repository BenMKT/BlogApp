class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  # Callback
  after_save :updates_user_posts_counter

  # Validations
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Methods
  def updates_user_posts_counter
    user.update(posts_counter: user.posts.count)
  end

  def five_most_recent_comments
    comments.includes(:user).order(created_at: :desc).limit(5)
  end
end
