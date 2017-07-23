class AnswerSerializer < BaseSerializer
  attributes :content, :upvotes_count, :downvotes_count, :replies_count, :views
  belongs_to :user
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
