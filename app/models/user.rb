# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts
  has_one_attached :avatar
  validates :username, :full_name, :privacy, presence: true
  validates :username, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
end
