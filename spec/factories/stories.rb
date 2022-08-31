# frozen_string_literal: true

FactoryBot.define do
  factory :story do
    sequence(:id)

    after(:build) do |story|
      story.images.attach(io: File.open('spec/fixtures/home4.png'), filename: 'test_image.png',
                          content_type: 'image/png')
    end
  end
end
