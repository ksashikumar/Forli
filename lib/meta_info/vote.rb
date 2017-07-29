class MetaInfo::Vote
  include Redis::Keys

  attr_accessor :user_id, :votable_type, :votable_id

  def initialize(options)
    self.user_id      = options[:user_id]
    self.votable_id   = options[:votable_id]
    self.votable_type = options[:votable_type]
  end

  def upvoted?
    hash_value == '1'
  end

  def downvoted?
    hash_value == '0'
  end

  def upvote!
    if hash_key_exists?
      if downvoted?
        $redis.perform('HSET', redis_key, hash_key, '1')
        votable.update_counters(votable_id, upvotes_count: 1, downvotes_count: -1)
      end
    else
      $redis.perform('HSET', redis_key, hash_key, '1')
      votable.update_counters(votable_id, upvotes_count: 1)
    end
  end

  def downvote!
    if hash_key_exists?
      if upvoted?
        $redis.perform('HSET', redis_key, hash_key, '0')
        votable.update_counters(votable_id, downvotes_count: 1, upvotes_count: -1)
      end
    else
      $redis.perform('HSET', redis_key, hash_key, '0')
      votable.update_counters(votable_id, downvotes_count: 1)
    end
  end

  def dump_to_db; end

  private

  def redis_key
    format(USER_VOTE_HSET, user_id: user_id)
  end

  def hash_key
    if votable_type == 'discussion'
      "d_#{votable_id}"
    elsif votable_type == 'answer'
      "a_#{votable_id}"
    end
  end

  def hash_key_exists?
    # $redis.perform('HEXISTS', hash_key) - Should we consider this?
    hash_value.present?
  end

  def hash_value
    @hash_value ||= $redis.perform('HGET', redis_key, hash_key)
  end

  def votable
    Object.const_get(votable_type.camelize)
  end
end
