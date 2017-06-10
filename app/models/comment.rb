class Comment < ApplicationRecord
  has_ancestry
  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
