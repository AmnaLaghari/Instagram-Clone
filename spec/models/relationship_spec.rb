# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  context 'Associations' do
    it { is_expected.to belong_to(:follower).class_name(:User) }
    it { is_expected.to belong_to(:followee).class_name(:User) }
  end

  context 'validations' do
    it { is_expected.to validate_uniqueness_of(:follower_id).scoped_to(:followee_id) }
    it { is_expected.to validate_uniqueness_of(:followee_id).scoped_to(:follower_id) }
  end
end
