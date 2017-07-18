class MetaInfo::Vote

  attr_accessor :user_id, :votable_type, :votable_id, :action

  def initialize(user_id)
    self.user_id = user_id
  end

  def upvoted?(votable_id, votable_type)
  end

  def downvoted?(votable_id, votable_type)
  end

  def upvote!(votable_id, votable_type)
  end

  def downvote!(votable_id, votable_type)
  end

  def dump_to_db
  end

end