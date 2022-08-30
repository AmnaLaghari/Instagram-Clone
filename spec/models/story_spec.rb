# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story, type: :model do
  let(:user) do
    User.create(username: Faker::Name.unique.name, full_name: Faker::Name.name, email: Faker::Internet.email,
                password: Faker::Internet.password(min_length: 6), privacy: 'Private')
  end

  let(:story) do
    Story.create(user_id: user.id,
                 images: [fixture_file_upload(Rails.root.join('spec/fixtures/home4.png'),
                                              'image/png')])
  end

  context 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many_attached(:images) }
  end

  context 'validations' do
    it 'is valid as it has image' do
      expect(story).to be_valid
    end

    it 'is not valid as it doesnt have image' do
      expect(Story.new).not_to be_valid
    end
  end

  context 'Scope' do
    it 'returns the specific user stories' do
      expect(Story.user_stories(user).pluck(:user_id)[0].eql?(user.id))
    end
  end

  context 'Delete story' do
    it 'should create story' do
      s1 = Story.create(user_id: user.id,
                        images: [fixture_file_upload(
                          Rails.root.join('spec/fixtures/home4.png'), 'image/png'
                        )])

      expect { DeleteStoriesJob.set(wait: 1.day).perform_later(s1.id) }.to have_enqueued_job.with(s1.id)
    end
  end
end
