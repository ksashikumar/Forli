class Comment < ApplicationRecord

  MAX_LEVEL = 15

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many   :comments, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  before_validation :calculate_level

  validate :validate_level

  before_create :change_parent_count, if: parent.present?

  def calculate_level
    self.level = parent ? (parent.level + 1) : 0
  end

  def validate_level
    if self.level > MAX_LEVEL
      self.errors.add(:level, :limit_reached, message: 'Maximum child limit reached')
      return false
    end
  end

  def change_parent_count
    parent_child_count = parent.child_count
    parent.child_count = parent_child_count + 1
  end

end
