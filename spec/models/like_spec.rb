# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post1) { create(:post, user: user) }
  let(:like1) { create(:like, user_id: user.id, post_id: post1.id) }

  context 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  context 'validations' do
    it 'should validate uniquness of user_id' do
      expect(like1).to be_valid
    end
  end
end
