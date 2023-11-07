require 'rails_helper'

RSpec.feature 'User Index', type: :feature do
    before do
    @user = User.create(name: 'Benson', bio: 'Teacher', photo: 'https://thispeotexist.com/')
    @post = @user.posts.create(title: 'Post title', text: 'Post body')

    visit user_path(@user)
    end

    it 'displays the profile picture for each user' do
        expect(page).to have_css(".profile-photo")
    end

    it 'displays the number of posts each user has written' do
        expect(page).to have_content(@user.posts_counter.to_s)
    end

    it 'redirects to the user show page when a user is clicked' do
        click_link @user.name
        expect(page).to have_current_path(user_path(@user))
    end
end
