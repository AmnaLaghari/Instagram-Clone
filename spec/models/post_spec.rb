# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.create(username: Faker::Name.unique.name, full_name: Faker::Name.name, email: Faker::Internet.email,
                password: Faker::Internet.password(min_length: 6), privacy: 'Private')
  end
  let(:post1) do
    Post.create(user_id: user.id, caption: Faker::Lorem.sentence,
                images: [fixture_file_upload(Rails.root.join('spec/fixtures/home4.png'), 'image/png')])
  end
  let(:post2) do
    Post.create(user_id: user.id, caption: Faker::Lorem.sentence,
                images: [fixture_file_upload(Rails.root.join('spec/fixtures/home4.png'), 'image/png')])
  end
  let(:post3) do
    Post.new
  end

  context 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
  end

  context 'relations' do
    it { is_expected.to have_many_attached(:images) }
  end

  context 'validations' do
    it 'validates presence of images and images are greater than 1' do
      expect(post1.images.count >= 1).to eq(true)
    end

    it 'validates images are less than 11' do
      expect(post1.images.count <= 10).to eq(true)
    end

    it 'should validate images cannot be more than 11' do
      11.times do
        post2.images.attach(io: File.open('spec/fixtures/home4.png'), filename: 'home4.png', content_type: 'image/png')
      end

      expect(post2.images.count <= 10).to eq(false)
    end

    it 'should validate images cannot be 0' do
      expect(post3.images.count >= 1).to eq(false)
    end
  end
end
