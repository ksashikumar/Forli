module Concerns::DiscussionPost

  def upvote
    MetaInfo::Vote.new(vote_hash).upvote!
    render_201
  end

  def downvote
    MetaInfo::Vote.new(vote_hash).downvote!
    render_201
  end

  def view
    MetaInfo::ViewCount.new(view_count_hash).hit!
    render_201
  end

  protected

  def vote_hash
    {
      votable_id: params[:id],
      votable_type: cname,
      user_id: current_user.id
    }
  end

  def view_count_hash
    {
      viewable_id: params[:id],
      viewable_type: cname
    }
  end

end