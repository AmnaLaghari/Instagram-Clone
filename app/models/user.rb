# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar
  validates :username, :full_name, :privacy, presence: true
  validates :username, uniqueness: true
  validate :confrim_passowrd
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :posts, dependent: :destroy
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Relationship', dependent: :destroy
  has_many :followee, through: :followed_users, source: :followee
  has_many :following_users, foreign_key: :followee_id, class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :following_users, source: :follower
  has_many :recieved_requests, class_name: 'Request', foreign_key: :reciever_id, dependent: :destroy
  has_many :sent_requests, class_name: 'Request', foreign_key: :sender_id, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :stories, dependent: :destroy

  def following?(user)
    return true if followee.include?(user)

    errors[:base] << 'You are not following this user'
  end

  def accept_request(user)
    ActiveRecord::Base.transaction do
      if following_users.create!(follower_id: user.id)
        user.sent_requests.find_by(reciever_id: id).destroy
        return true
      end
    end
  rescue ActiveRecord::RecordInvalid
    errors[:base] << 'something went wrong'
  end

  def delete_request(user)
    return true if sent_requests.find_by(reciever_id: user.id).destroy

    errors[:base] << 'Request not deleted successfully'
  end

  private

  def confrim_passowrd
    return true if :password.eql? :password_confirmation

    errors[:base] << 'Password doesnt match confirm password'
  end
end
