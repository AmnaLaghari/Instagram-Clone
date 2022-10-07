# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post1) { create(:post, user: user) }
  let(:post2) { create(:post, user: user) }
  let(:post3) do
    Post.new
  end
  let(:post4) do
    build(:post, user: user, images: [fixture_file_upload(
      Rails.root.join('spec/fixtures/Alchemist.webp'), 'image/png'
    )])
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

    it 'Image is valid as its type valid(png)' do
      expect(post2).to be_valid
    end

    it 'Image is invalid as its type invalid(webp)' do
      byebug
      expect(post4).to_not be_valid
    end
  end
end
