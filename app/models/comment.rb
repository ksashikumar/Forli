class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many   :comments, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  def calculate_level
    self.level = parent ? (parent.level + 1) : 0
  end

end
