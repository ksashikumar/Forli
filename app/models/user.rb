class User < ApplicationRecord
  has_many :user_categories
  has_many :categories, through: :user_categories

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :user_notifications
  has_many :notifications, through: :user_notifications

  before_save :ensure_tokens

  scope :name_like, ->(name) {
    where(['LOWER(name) LIKE LOWER(?)', "#{name}%"])
  }

  def ensure_tokens
    tokens = generate_authentication_token if tokens.blank?
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(tokens: token).first
    end
  end
end
