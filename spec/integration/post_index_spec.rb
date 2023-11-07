require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do
  before do
    @user = User.create(name: 'Ahmed', bio: 'Teacher', photo: 'https://thispeotexist.com/')
    @post = @user.posts.create(title: 'Post title', text: 'Post body') # create a post
    @comment = @post.comments.create(user_id: @user.id, text: 'Comment body') # create a comment
  end

  describe 'User and posts display' do
  before do
    visit user_path(@user, @post)
  end

  it 'displays user name' do
    expect(page).to have_content(@user.name)
  end

  it 'displays post title' do
    expect(page).to have_content(@post.title)
  end

  it 'displays post text' do
    expect(page).to have_content(@post.text)
  end

  it 'displays post comments counter' do
    expect(page).to have_content(@post.comments_counter)
  end

  it 'displays post likes counter' do
    expect(page).to have_content(@post.likes_counter)
  end

  it 'displays the profile picture for each user' do
    expect(page).to have_css('.profile-photo')
  end
  
  it 'displays user posts counter' do
    expect(page).to have_content(@user.posts_counter)
  end
end

  it 'displays the first comments on a post' do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@comment.text)
  end

  it 'displays pagination when there are more posts than fit on one page' do
    21.times { @user.posts.create(title: 'Post title', text: 'Post body') }
    visit user_posts_path(@user)
    expect(page).to have_selector('div.pagination')
  end

  it "redirects to post's show page when a post is clicked" do
    visit user_posts_path(@user)
    click_link @post.title
    expect(page).to have_current_path(user_post_path(@user, @post))
  end
end
