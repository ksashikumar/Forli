class TagFilter < ApplicationRecord
  serialize :data, Array

  belongs_to :user

  validates_uniqueness_of :name, scope: :user_id

  validate :check_data

  def check_data
    if data.empty?
      errors.add(:data, :not_allowed, message: 'Tag array should not be empty')
      false
    end
  end

  def tag_ids
    data
  end

  def tag_ids=(ids)
    self.data = ids
  end
end
