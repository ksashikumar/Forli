class Tag < ApplicationRecord
  has_many :discussion_tags
  has_many :discussions, through: :discussion_tags
end
