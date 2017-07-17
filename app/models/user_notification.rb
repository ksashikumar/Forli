class UserNotification < ApplicationRecord
  belongs_to :user
  belongs_to :notification

  attr_accessor :is_read
end
