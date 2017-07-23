class DiscussionSerializer < BaseSerializer
  attributes  :title, :description, :upvotes_count, :downvotes_count, :answers_count, :follows_count, :views, :user, :sentiment
  belongs_to :user
  belongs_to :category
  has_many :answers
  has_many :tags
  attribute :vote_action, if: :current_user

  def vote_action
    vote_obj = MetaInfo::Vote.new(votable_id: object.id, votable_type: 'discussion', user_id: current_user.id)
    if(vote_obj.upvoted?)
      return 2
    elsif(vote_obj.downvoted?)
      return 1
    else
      return 0
    end
  end
end
