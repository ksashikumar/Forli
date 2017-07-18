class MetaInfo::ViewHit

  attr_accessor :user_id, :viewable_type, :viewable_id

  def initialize(options)
    self.user_id       = options[:user_id]
    self.viewable_id   = options[:viewable_id]
    self.viewable_type = options[:viewable_type]
  end

  def hit
  end

  def dump_to_db
  end

end