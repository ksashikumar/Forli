class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :posts
  has_many :comments, as: :commentable
  has_many :notifications
end
