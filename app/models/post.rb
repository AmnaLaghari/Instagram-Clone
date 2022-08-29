# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :images, length: { minimum: 1, maximum: 10, message: 'can not exceed 10 per post.' }
end
