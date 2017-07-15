class Category < ApplicationRecord

  MAX_CHILDREN = 5

  belongs_to :user
  belongs_to :parent, class_name: 'Category', optional: true
  has_many   :categories, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy

  before_validation :change_parent_child_count, if: :parent_present?
  validates_uniqueness_of :name
  validate :check_hierarchy, if: :parent_present?

  after_create :update_parent, if: :parent_present?

  def change_parent_child_count
    parent_child_count = parent.child_count
    parent.child_count = parent.child_count + 1
  end

  def check_hierarchy
    if parent.parent_id.present?
      self.errors.add(:parent, :not_allowed, message: 'Could not be associated')
      return false
    end
    if parent.child_count > MAX_CHILDREN
      self.errors.add(:parent, :not_allowed, message: 'Numer of children limit reached')
      return false
    end
  end

  def update_parent
    # Need to revisit
    parent.save
  end

  private
    def parent_present?
      parent.present?
    end
end
