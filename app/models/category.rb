class Category < ApplicationRecord

  MAX_LEVEL = 5

  enum visibility: [:open, :moderator_only, :admin_only]

  belongs_to :user
  belongs_to :parent, class_name: 'Category', optional: true
  has_many   :categories, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy

  validates_uniqueness_of :name
  validate :check_parent_visibility
  validate :validate_level

  before_validation :calculate_level

  def check_parent_visibility
    if parent.present?
      if open? && (parent.moderator_only? || parent.admin_only?)
        self.errors.add(:visibility, :not_allowed, message: 'Could not be associated')
        return false
      end
      if moderator_only? && parent.admin_only?
        self.errors.add(:visibility, :not_allowed, message: 'Could not be associated')
        return false
      end
    end
  end

  def validate_level
    if self.level > MAX_LEVEL
      self.errors.add(:level, :limit_reached, message: 'Maximum child level reached')
      return false
    end
  end

  def calculate_level
    self.level = parent ? (parent.level + 1) : 0
  end

  def children
    self.categories.where(['level > ?', level])
  end

end
