require 'rails_helper'
require 'spec_helper'
require 'devise'

RSpec.describe "UsersControllers", type: :request do
  user = User.first

  describe "Users/index" do
    it 'show all users' do
      sign_in user
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "User/show" do
    it 'Show single user' do
      sign_in user
      get user_path(user.id),params:{user: {username: user.username, full_name: user.full_name, email: user.email, password: user.password, privacy: user.privacy}}
      expect(response).to have_http_status(200)
    end
  end

  describe "User/search" do
    it 'searches user' do
      sign_in user
      get search_path()
      expect(response).to have_http_status(200)
    end
  end
end
