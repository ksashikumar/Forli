class DiscussionSerializer < BaseSerializer
  attributes  :title, :description, :upvotes_count, :downvotes_count, :posts_count, :comments_count, :follows_count, :views, :user, :sentiment
  belongs_to :user
  belongs_to :category
  has_many :posts
  has_many :tags
end
