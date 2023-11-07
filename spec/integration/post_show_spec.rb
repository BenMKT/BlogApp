require 'rails_helper'

RSpec.feature 'Post show page', type: :feature do
    before do
        @user = User.create(name: 'Benson', bio: 'Teacher', photo: 'https://thispeotexist.com/')
        @post = @user.posts.create(title: 'Post title', text: 'Post body') # create a post
        @comment = @post.comments.create(user_id: @user.id, text: 'Comment body') # create a comment

        visit user_post_path(@user, @post)
    end

    it 'shows the post title' do
        expect(page).to have_content(@post.title)
    end

    it 'shows the post author' do
    expect(page).to have_content(@post.user.name)
    end

    it 'shows the number of comments' do
    expect(page).to have_content("Comments: #{@post.comments_counter}")
    end

    it 'shows the number of likes' do
    expect(page).to have_content("Likes: #{@post.likes_counter}")
    end

    it 'shows the username of each commentor' do
    @post.comments.each do |comment|
        expect(page).to have_content(comment.user.name)
    end
  end

    it 'shows the comment each commentor left' do
    @post.comments.each do |comment|
        expect(page).to have_content(comment.text)
    end
  end
end
