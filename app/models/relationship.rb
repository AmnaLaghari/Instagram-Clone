# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User', inverse_of: :followed_users
  belongs_to :followee, class_name: 'User', inverse_of: :following_users

  validates :follower_id, uniqueness: { scope: :followee_id }
  validates :followee_id, uniqueness: { scope: :follower_id }
end
