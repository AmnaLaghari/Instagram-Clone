# frozen_string_literal: true

class Story < ApplicationRecord
  after_save :delete_story

  belongs_to :user
  has_many_attached :images, dependent: :destroy

  validates :images, presence: true

  scope :user_stories, ->(id) { where(user_id: id) }

  private

  def delete_story
    DeleteStoriesJob.set(wait: 1.day).perform_later(id)
  end
end
