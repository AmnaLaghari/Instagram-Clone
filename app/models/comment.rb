# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true, acceptance: { message: 'Cant be blank' }
end
