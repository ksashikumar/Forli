class Tag < ApplicationRecord
  has_many :discussion_tags
  has_many :discussions, through: :discussion_tags

  scope :name_like, -> (name) {
    where(["LOWER(name) LIKE LOWER(?)", "#{name}%"])
  }

end
