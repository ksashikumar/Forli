class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :posts
  has_many :comments, as: :commentable
  has_many :discussion_tags
  has_many :tags, through: :discussion_tags
end
