# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar
  validates :username, :full_name, :privacy, presence: true
  validates :username, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :posts, dependent: :destroy

  has_many :followers, foreign_key: :follower_id , class_name: "Relationshop"

  has_many :followee, through: :followers

  has_many :followee, foreign_key: :followee_id, class_name: "Relationshop"

  has_many :followers, through: :followee


end
