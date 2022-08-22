# frozen_string_literal: true

class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: :post_id, message: 'can like post once.' }
  belongs_to :user
  belongs_to :post
end
