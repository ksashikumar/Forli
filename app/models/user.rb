class User < ApplicationRecord
  has_many :user_categories
  has_many :categories, through: :user_categories

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false

  validate :check_valid_name

  has_many :user_notifications
  has_many :notifications, through: :user_notifications
  has_many :tag_filters

  before_save :ensure_tokens
  before_create :set_preferences

  # Query users who only have allow_tagging enabled
  scope :name_like, ->(name) {
    where(["LOWER(name) LIKE LOWER(?) AND preferences -> 'allow_tagging' = 'true'", "#{name}%"])
  }

  def self.valid_name?(name)
    !name.include?(' ')
  end

  def self.name_exists?(name)
    where(['LOWER(name) = LOWER(?)', name.to_s]).present?
  end

  def check_valid_name
    if name.include?(' ')
      errors.add(:name, :not_allowed, message: 'Should not have spaces')
      false
    end
  end

  def ensure_tokens
    self.tokens = generate_authentication_token if tokens.blank?
  end

  def set_preferences
    UserConstants::PREFERENCES.each do |preference|
      self.preferences ||= {}
      self.preferences[preference.to_s] = 'true'
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(tokens: token).first
    end
  end

  def preferences_hash
    result_hash = {}
    self.preferences ||= {}
    UserConstants::PREFERENCES.each do |preference|
      result_hash[preference] = if self.preferences.key?(preference.to_s)
                                  (self.preferences[preference.to_s] == 'true')
                                else
                                  true
                                end
    end
    result_hash
  end

  UserConstants::PREFERENCES.each do |preference|
    define_method "#{preference}_enabled?" do
      preferences_hash[preference]
    end
  end
end
