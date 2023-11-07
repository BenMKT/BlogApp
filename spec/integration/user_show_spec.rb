require 'rails_helper'

RSpec.describe 'User show page', type: :feature do # rubocop:disable Metrics/BlockLength
  before do
    @user = User.create(name: 'Benson', bio: 'Teacher', photo: 'https://thispeotexist.com/')
    @post = @user.posts.create(title: 'Post title', text: 'Post body')

    visit user_path(@user, @post)
  end

  it 'displays the user profile picture' do
    expect(page).to have_css('.profile-photo')
  end

  it 'displays the user username' do
    expect(page).to have_content(@user.name)
  end

  it 'displays the post body' do
    expect(page).to have_content(@post.text)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content(@user.posts_counter.to_s)
  end

  it 'displays the user bio' do
    expect(page).to have_content(@user.bio)
  end

  it 'displays the user first 3 posts' do
    5.times do |i|
      @user.posts.create(title: "Post #{i}", text: "Post text #{i}")
    end
    visit user_path(@user)
    @user.posts.order(created_at: :desc).first(3).each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
    expect(page).not_to have_content('Post 0')
    expect(page).not_to have_content('Post 1')
  end

  it 'displays a button to view all of the user posts' do
    expect(page).to have_link('See All Posts', href: user_posts_path(@user))
  end

  it "redirects to post's show page when a post is clicked" do
    visit user_posts_path(@user)
    click_link @post.title
    expect(page).to have_current_path(user_post_path(@user, @post))
  end

  it 'redirects to the user posts index page when clicking on See all posts' do
    click_link 'See All Posts'
    expect(current_path).to eq(user_posts_path(@user))
  end
end
