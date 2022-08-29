# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:id)
    email { 'amna.laghari243@gmail.com' }
    password { '123456' }
    username { 'Amna2101' }
    full_name { 'Amna Laghari' }
    privacy { 'Public' }
  end
end
