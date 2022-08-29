# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:stories).dependent(:destroy) }
    it { is_expected.to have_many(:followed_users).class_name('Relationship').dependent(:destroy) }
    it { is_expected.to have_many(:followee).through(:followed_users) }
    it { is_expected.to have_many(:following_users).class_name('Relationship').dependent(:destroy) }
    it { is_expected.to have_many(:followers).through(:following_users) }
    it { is_expected.to have_many(:recieved_requests).class_name('Request').dependent(:destroy) }
    it { is_expected.to have_many(:sent_requests).class_name('Request').dependent(:destroy) }
    it { is_expected.to have_one_attached(:avatar) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_uniqueness_of(:username) }
  end

  context 'Scope' do
    let(:user) { build :user }
    it 'returns the users with matching full_name'do
      expect(User.name_search(user.username).pluck(:username).eql? user.username)
    end
  end

  context 'following?' do
    let(:user) { build :user }
    it 'check following' do
      expect(user.following?(user)).to eq(false)
    end
  end

  context 'accept request' do
    u1 = User.find(1)
    u2 = User.find(2)
    r = u2.sent_requests.new(reciever_id: u1.id)
    r.save
    it 'should accept request' do
      expect(u1.accept_request(u2)).to eq(true)
    end

    it 'should not accept request' do
      u1.accept_request(u2)
      expect(u1.accept_request(u2)).to include('something went wrong')
    end
  end

  context 'delete request' do
    u1 = User.find(1)
    u3 = User.find(3)
    Request.create(sender_id: u1.id, reciever_id: u3.id)
    it 'should delete reuqest' do
      expect(u1.delete_request(u3)).to eq(true)
    end

    # it 'should not delete reuqest' do
    #   expect(u1.delete_request(u3)).to include('Request not deleted successfully')
    # end
  end
end
