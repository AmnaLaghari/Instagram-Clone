# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:id)
    username { Faker::Name.unique.name }
    password { Faker::Internet.password(min_length: 6) }
    full_name { Faker::Name.unique.name }
    email { Faker::Internet.email }
    after(:build, &:skip_confirmation_notification!)
    after(:create, &:confirm)
  end
end
