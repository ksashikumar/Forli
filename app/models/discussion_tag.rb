class DiscussionTag < ApplicationRecord
  belongs_to :discussion
  belongs_to :tag

  after_create :update_tag_count

  def update_tag_count
    Tag.update_counters(self.tag.id, count: 1)
  end
end
