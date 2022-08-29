# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post , type: :model do
  context 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
  end

  context 'relations' do
    it { is_expected.to have_many_attached(:images) }
  end
  context 'validations' do
    post1 = Post.first

    it 'validates presence of images and images are greater than 1' do
      expect(post1.images.count>0)
    end
    it 'validates images are less than 11' do
      expect(post1.images.count<11)
    end
  end
end
