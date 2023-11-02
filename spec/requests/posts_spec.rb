require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) do
    User.create(
      name: 'Benson',
      photo: 'https://www.google.com/imghp?hl=en&ogbl',
      bio: 'Full Stack Developer',
      posts_counter: 2
    )
  end

  let!(:post) do
    Post.create(
      title: 'Become a Full stack',
      text: 'Build aweasome projects',
      author_id: user.id,
      comments_counter: 4,
      likes_counter: 7
    )
  end

  describe 'GET /index' do
    before do
      get "/users/#{user.id}/posts/"
    end

    it 'renders post template' do
      expect(response).to render_template(:index)
    end

    it 'includes the post title in the response body' do
      expect(response.body).to include(post.title)
    end
  end

  describe 'GET /show' do
    before do
      get "/users/#{user.id}/posts/#{post.id}"
    end

    it 'returns success for detail post' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders post detail template' do
      expect(response).to render_template(:show)
    end

    it 'post detail response body includes correct placeholder text' do
      expect(response.body).to include(post.text)
    end
  end
end
