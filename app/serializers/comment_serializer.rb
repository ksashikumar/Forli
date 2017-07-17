class CommentSerializer < BaseSerializer
  attributes :content, :child_count
  belongs_to :user
end