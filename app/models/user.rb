class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  has_many :user_categories
  has_many :categories, through: :user_categories

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :confirmable, :omniauthable, :trackable
end
