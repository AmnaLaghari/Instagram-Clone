# frozen_string_literal: true

class Story < ApplicationRecord
  after_save :delete_story

  belongs_to :user
  has_many_attached :images, dependent: :destroy

  validates :images, presence: true
  validate :correct_image_type

  scope :user_stories, ->(id) { where(user_id: id) }

  private

  def delete_story
    DeleteStoriesJob.set(wait: 1.day).perform_later(id)
  end

  def correct_image_type
    return unless images.attached?

    images.each do |image|
      unless image.content_type.in?(%w[image/jpeg image/png image/gif image/jpg])
        errors[:base] << 'You tried uploading which is not jpeg/jpg/png/gif'
      end
    end
  end
end
