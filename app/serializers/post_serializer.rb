class PostSerializer < BaseSerializer
  attributes :content, :upvotes_count, :downvotes_count, :comments_count, :views
  belongs_to :user
end
