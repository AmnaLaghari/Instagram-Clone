# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'devise'

RSpec.describe 'PostsControllers', type: :request do
  let(:user) { create(:user) }
  let(:post1) { create(:post, user: user) }
  let(:user2) { create(:user) }
  let(:post2) { create(:post, user: user2) }

  before(:each) do
    user.skip_confirmation!
    sign_in user
  end

  describe 'Posts/index' do
    it 'should show all posts as user is signed in' do
      get posts_path(post1.id)

      expect(response).to have_http_status(200)
    end

    it 'should not show all posts as user is not signed in' do
      sign_out user
      get posts_path(post1.id)

      expect(response).to have_http_status(401)
      expect(response.body).to include('You need to sign in or sign up before continuing.')
    end
  end

  describe 'Posts/edit' do
    it 'should edit post as user is signed in' do
      get edit_post_path(post1.id)

      expect(response).to have_http_status(200)
    end

    it 'should not edit post as user is not signed it' do
      sign_out user
      get edit_post_path(post1.id)

      follow_redirect!
      expect(response.body).to include('You need to sign in or sign up before continuing.')
    end

    it 'should not edit post as signed in user is not the creator of post' do
      sign_out user
      user2.skip_confirmation!
      sign_in user2
      get edit_post_path(post1.id)

      follow_redirect!
      expect(flash[:notice]).to eq('You are not authorized to perform this action.')
    end
  end

  describe 'Posts/new' do
    it 'should create new post as user is signed in' do
      get new_post_path

      expect(response).to have_http_status(200)
    end

    it 'should not create new post as user is not signed in' do
      sign_out user
      get new_post_path

      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include('You need to sign in or sign up before continuing.')
    end
  end

  describe 'Posts/show' do
    it 'should show post as user is signed in' do
      get post_path(post1.id)

      expect(response).to have_http_status(200)
    end

    it 'should not show post as user is not signed in' do
      sign_out user
      get post_path(post1.id)

      follow_redirect!
      expect(response.body).to include('You need to sign in or sign up before continuing.')
    end
  end

  describe 'Posts/create' do
    it 'should create post as all params are correct' do
      post posts_path,
           params: { post: { user_id: user.id, caption: Faker::Lorem.sentence,
                             images: [fixture_file_upload(Rails.root.join('spec/fixtures/home4.png'), 'image/png')] } }

      expect(response).to have_http_status(302)
      follow_redirect!
      expect(flash[:notice]).to eql('Post was successfully created.')
    end

    it 'should not create post as params' do
      post posts_path, params: { post: { caption: 'sese' } }

      expect(response).to have_http_status(422)
    end
  end

  describe 'Posts/update' do
    it 'should update post as params are correct and user is signed in' do
      put "/posts/#{post1.id}",
          params: { post: { user_id: post1.user_id, caption: post1.caption, images: post1.images } }
      follow_redirect!

      expect(flash[:notice]).to eql('post was successfully updated.')
    end

    it 'should not update as params are not correct' do
      patch "/posts/#{post1.id}", params: { post: { user_id: 67 } }
      post1.update(user_id: 67)
      expect(flash[:notice]).to eql("Post was not successfully updated. Please try again.
                  #{post1.errors.full_messages.to_sentence} ")
    end

    it 'should not update post as signed in user is not creator of post' do
      sign_out user
      user2.skip_confirmation!
      sign_in user2
      put "/posts/#{post1.id}", params: { post: { user_id: user2.id } }
      follow_redirect!

      expect(flash[:notice]).to eql('You are not authorized to perform this action.')
    end
  end

  describe 'Post/destroy' do
    it 'should destroy as parmas are correct and signed in user is the ceeator of post' do
      delete "/posts/#{post1.id}", params: { post: { user_id: post1.user_id } }

      follow_redirect!
      expect(flash[:notice]).to eql('Post was successfully deleted.')
    end

    it 'should not destroy post as we are returining false' do
      allow(Post).to receive(:find).and_return(post1)
      allow(post1).to receive(:destroy).and_return(false)
      delete "/posts/#{post1.id}"
      follow_redirect!

      expect(flash[:notice]).to eql("Something went wrong.#{post1.errors.full_messages.to_sentence}")
    end

    it 'should not destroy post as user is not signed in' do
      sign_out user
      delete "/posts/#{post1.id}"

      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include('You need to sign in or sign up before continuing.')
    end
  end
end
