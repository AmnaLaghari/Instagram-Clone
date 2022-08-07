# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  validates :images, length: { minimum: 0, maximum: 10, message: 'can not exceed 10 per post.' }
  validate :correct_image_type

  private

  def correct_image_type
    return unless images.attached?

    images.each do |image|
      unless image.content_type.in?(%w[image/jpeg image/png image/gif image/jpg])
        errors[:base] << 'You tried uploading which is not jped/jpg/png.gif'
      end
    end
  end
end
