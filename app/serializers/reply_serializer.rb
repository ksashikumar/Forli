class ReplySerializer < BaseSerializer
  attributes :content
  belongs_to :user
end