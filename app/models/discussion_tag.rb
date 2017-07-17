class DiscussionTag < ApplicationRecord
  belongs_to :discussion
  belongs_to :tag
end
