class Post < ApplicationRecord
  belongs_to :discussion
  belongs_to :user
  has_many :comments, as: :commentable
end
