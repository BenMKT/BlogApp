require 'rails_helper'

RSpec.feature 'Post index page', type: :feature do
  before do
    @user = User.create(name: 'Ahmed', bio: 'Teacher', photo: 'https://thispeotexist.com/')
    @post = @user.posts.create(title: 'Post title', text: 'Post body') # create a post
  end

  it 'displays user and posts correctly' do
    visit user_path(@user, @post)
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.text)
    expect(page).to have_content(@post.comments_counter)
    expect(page).to have_content(@post.likes_counter)
    expect(page).to have_content(@user.posts_counter)
    # Add more expectations for other elements
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
