# frozen_string_literal: true

u1 = User.find_or_create_by(full_name: 'Amna Laghari', email: 'amna.laghari243@gmail.com', username: 'amna2101',
  privacy: 'Private') do |user|
  user.password = '123456'
end
u1.skip_confirmation!
u1.save!

u2 = User.find_or_create_by(full_name: 'meenu', email: 'amna.laghari@devsinc.com', username: 'meenu',
  privacy: 'Private') do |user|
user.password = '123456'
end
u2.skip_confirmation!
u2.save!

u3 = User.find_or_create_by(full_name: 'smols.art', email: 'smols.art21@gmail.com', username: 'Smola.art',
  privacy: 'Public') do |user|
user.password = '123456'
end
u3.skip_confirmation!
u3.save!
