# frozen_string_literal: true

u1 = User.find_or_create_by(full_name: 'Amna Laghari', email: 'amna.laghari243@gmail.com', username: 'amna2101',
                            privacy: 'Private') do |user|
  user.password = '123456'
end
u1.skip_confirmation!
u1.save!

u4 = User.find_or_create_by(full_name: 'Ali', email: 'aali274297@gmail.com', username: 'ali791',
  privacy: 'Private') do |user|
user.password = '123456'
end
u4.skip_confirmation!
u4.save!

u2 = User.find_or_create_by(full_name: 'meenu', email: 'amna.laghari@devsinc.com', username: 'meenu',
                            privacy: 'Private') do |user|
  user.password = '123456'
end
u2.skip_confirmation!
u2.save!

u3 = User.find_or_create_by(full_name: 'smols.art', email: 'smols.art21@gmail.com', username: 'Smols.art',
                            privacy: 'Public') do |user|
  user.password = '123456'
end
u3.skip_confirmation!
u3.save!

Post.create(caption: 'post1', user_id: u1.id) do |post|
  post.images.attach(io: File.open('app/assets/images/p1.jpeg'), filename: 'p1.jpeg')
end

Story.create(user_id: u1.id) do |story|
  story.images.attach(io: File.open('app/assets/images/user.png'), filename: 'p2.jpeg')
end

Post.create(caption: 'post1', user_id: u4.id) do |post|
  post.images.attach(io: File.open('app/assets/images/p1.jpeg'), filename: 'p1.jpeg')
end

Story.create(user_id: u4.id) do |story|
  story.images.attach(io: File.open('app/assets/images/user.png'), filename: 'p2.jpeg')
end

Post.create(caption: 'post1', user_id: u2.id) do |post|
  post.images.attach(io: File.open('app/assets/images/p1.jpeg'), filename: 'p1.jpeg')
end

Story.create(user_id: u2.id) do |story|
  story.images.attach(io: File.open('app/assets/images/user.png'), filename: 'p2.jpeg')
end

Post.create(caption: 'post1', user_id: u3.id) do |post|
  post.images.attach(io: File.open('app/assets/images/p1.jpeg'), filename: 'p1.jpeg')
end

Story.create(user_id: u3.id) do |story|
  story.images.attach(io: File.open('app/assets/images/user.png'), filename: 'p2.jpeg')
end

# r1 = Relationship.create!(follower_id: u1.id, followee_id: u2.id)
# r1.save!
