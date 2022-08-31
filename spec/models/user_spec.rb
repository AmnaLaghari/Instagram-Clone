# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user1) { create(:user, username: 'amna') }
  let(:user3) { create(:user, username: 'AMNA') }
  let(:user2) { create(:user) }

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
    it 'should check uniqueness of username' do
      expect(user1).to be_valid
    end

    it 'should check uniqueness of username' do
      expect(user3).to be_valid
    end
  end

  context 'Scope' do
    it 'returns the users with matching full_name' do
      expect(User.name_search(user.username).pluck(:username).eql?(user.username))
    end
  end

  context 'following?' do
    it 'should not follow itself' do
      expect(user.following?(user)).to eq(false)
    end

    it 'user should follow user2 as its relationship is created' do
      user.followed_users.create(followee_id: user2.id)

      expect(user.following?(user2)).to eq(true)
    end
  end

  context 'accept request' do
    it 'should accept request' do
      r = user2.sent_requests.new(reciever_id: user.id)
      r.save

      expect(user.accept_request(user2)).to eq(true)
    end

    it 'should not accept request because it is accepted twice' do
      r = user2.sent_requests.new(reciever_id: user.id)
      r.save
      user.accept_request(user2)

      expect(user.accept_request(user2)).to include(user2.errors.to_s)
    end
  end

  context 'delete request' do
    it 'should delete reuqest' do
      Request.create(sender_id: user.id, reciever_id: user2.id)

      expect(user.delete_request(user2)).to eq(true)
    end
  end
end
