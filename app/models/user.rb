class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  has_many :user_categories
  has_many :categories, through: :user_categories

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :confirmable, :omniauthable, :trackable

  has_many :user_notifications
  has_many :notifications, through: :user_notifications

  scope :name_like, -> (name) {
    where(["LOWER(name) LIKE LOWER(?)", "#{name}%"])
  }
end
