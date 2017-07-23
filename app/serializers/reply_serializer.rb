class ReplySerializer < BaseSerializer
  attributes :content, :answer_id
  belongs_to :user
end