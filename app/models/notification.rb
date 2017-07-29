class Notification < ApplicationRecord
  belongs_to :discussion

  has_many :user_notifications
  has_many :users, through: :user_notifications
end
