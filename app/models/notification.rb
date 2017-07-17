class Notification < ApplicationRecord
  belongs_to :discusssion

  has_many :user_notifications
  has_many :users, through: :user_notifications

  attr_accessor :content

end
