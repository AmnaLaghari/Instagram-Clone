# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sequence(:id)
    caption { Faker::Lorem.sentence }

    after(:build) do |post|
      post.images.attach(io: File.open('spec/fixtures/home4.png'), filename: 'test_image.png',
                         content_type: 'image/png')
    end
  end
end
