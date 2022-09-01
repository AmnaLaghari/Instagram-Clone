# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story, type: :model do
  let(:user) { create(:user) }
  let(:story) { create(:story, user: user) }
  let(:story2) do
    build(:story, user: user, images: [fixture_file_upload(
      Rails.root.join('spec/fixtures/Alchemist.webp'), 'image/png'
    )])
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

    it 'Image is valid as its type valid(png)' do
      expect(story).to be_valid
    end

    it 'Image is invalid as its type invalid(webp)' do
      expect(story2).to_not be_valid
    end
  end

  context 'Scope' do
    it 'returns the specific user stories' do
      expect(Story.user_stories(user).pluck(:user_id)[0].eql?(user.id))
    end
  end

  context 'Delete story' do
    it 'should create story' do
      expect { DeleteStoriesJob.set(wait: 1.day).perform_later(story.id) }.to have_enqueued_job.with(story.id)
    end
  end
end
