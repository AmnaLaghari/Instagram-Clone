require 'rails_helper'
require 'spec_helper'
require 'devise'

RSpec.describe 'UsersControllers', type: :request do
  user = User.first
  u2 = User.find(2)
  post = Post.first
  p2 = Post.find(2)
  describe 'Posts/index' do
    it 'show all posts' do
      sign_in user
      get posts_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'Posts/edit' do
    it 'Edit post' do
      sign_in user
      get edit_post_path(post.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'Posts/new' do
    it 'should create new post' do
      sign_in user
      get new_post_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'Posts/show' do
    it 'show post' do
      sign_in user
      get post_path(post.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'Posts/create' do
    it 'should create post' do
      sign_in user
      post posts_path, params: { post: { user_id: user.id, caption: 'sese', images: [fixture_file_upload(Rails.root.join('spec', 'fixtures', 'home4.png'), 'image/png')]} }
      follow_redirect!
      expect(response.body).to include('Post was successfully created.')
    end

    it 'shoule not create post' do
      sign_in user
      post posts_path, params: { post: { caption: 'sese' } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'Posts/update' do
    it 'should update post' do
      sign_in user
      put "/posts/#{post.id}", params: { post: { user_id: post.user_id, caption: post.caption, images: post.images } }
      follow_redirect!
      expect(response.body).to include('post was successfully updated.')
    end

    it 'should not update post' do
      sign_in user
      put "/posts/#{post.id}", params: { post: { user_id: 5 } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'Post/destroy' do
    it 'should destroy' do
      sign_in user
      delete "/posts/#{post.id}", params: { post: { user_id: post.user_id } }
      expect(response).to have_http_status(:redirect)
    end

    it 'should not destroy post' do
      sign_in user
      allow(Post).to receive(:find).and_return(post)
      allow(post).to receive(:destroy).and_return(false)
      delete "/posts/#{post.id}"
      follow_redirect!
      expect(response.body).to include("Something went wrong.#{post.errors.full_messages.to_sentence}")
    end
  end


end
