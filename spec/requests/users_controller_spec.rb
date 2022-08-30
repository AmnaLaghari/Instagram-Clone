# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'devise'

RSpec.describe 'UsersControllers', type: :request do
  let(:user) do
    User.create(username: Faker::Name.unique.name, full_name: Faker::Name.name, email: Faker::Internet.email,
                password: Faker::Internet.password(min_length: 6), privacy: 'Private')
  end

  before(:each) do
    user.skip_confirmation!
    sign_in user
  end

  describe 'Users/index' do
    it 'should show all users as user is signed in' do
      get users_path

      expect(response).to have_http_status(200)
    end

    it 'should not show all users as user is signed in' do
      sign_out user
      get users_path

      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include('You need to sign in or sign up before continuing.')
    end
  end

  describe 'User/show' do
    it 'Should show single user as user is signed in' do
      get user_path(user.id),
          params: { user: { username: user.username, full_name: user.full_name, email: user.email,
                            password: user.password, privacy: user.privacy } }

      expect(response).to have_http_status(200)
    end

    it 'Should not show single user as user is not signed in' do
      sign_out user
      get user_path(user.id),
          params: { user: { username: user.username, full_name: user.full_name, email: user.email,
                            password: user.password, privacy: user.privacy } }

      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include('You need to sign in or sign up before continuing.')
    end
  end

  describe 'User/search' do
    it 'should search user as user is signed in' do
      get search_path

      expect(response).to have_http_status(200)
    end

    it 'should not search user as user is not signed in' do
      sign_out user
      get search_path

      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include('You need to sign in or sign up before continuing.')
    end
  end
end
