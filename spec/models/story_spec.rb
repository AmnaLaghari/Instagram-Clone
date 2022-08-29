# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story , type: :model do
  context 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many_attached(:images) }
  end

  context 'validations' do
    it "requires the presence of a image" do
      expect(Story.new).not_to be_valid
    end
  end

  context 'Scope' do
    let(:user) { build :user }
    it 'returns the specific user stories'do
      expect(Story.user_stories(user).pluck(:user_id)[0].eql? user.id)
    end
  end

  context 'Delete story' do
    u1 = User.find(1)
    it 'should create story' do
      Story.create(user_id: u1.id, images: [fixture_file_upload(Rails.root.join('spec', 'fixtures', 'home4.png'), 'image/png')])
    end
  end
end

