class MetaInfo::ViewCount
  include Redis::Keys

  BATCH_THRESHOLD_VALUE = 100

  attr_accessor :viewable_type, :viewable_id

  def initialize(options)
    self.viewable_id   = options[:viewable_id]
    self.viewable_type = options[:viewable_type]
  end

  def count
    get_redis_count + viewable.find_by_id(viewable_id).views
  end

  def hit!
    new_count = increment_redis_count
    if new_count == BATCH_THRESHOLD_VALUE
      dump_to_db
      reset_redis_count
    end
  end

  def dump_to_db
    viewable.update_counters(viewable_id, views: BATCH_THRESHOLD_VALUE)
  end

  private

    def key
      send("#{viewable_type}_redis_key")
    end

    def discussion_redis_key
      DISCUSSION_VIEW_COUNT % { discussion_id: viewable_id }
    end

    def post_redis_key
      POST_VIEW_COUNT % { post_id: viewable_id }
    end

    def increment_redis_count
      $redis.perform('INCR', key)
    end

    def reset_redis_count
      $redis.perform('SET', key, 0)
    end

    def get_redis_count
      $redis.perform('GET', key)
    end

    def viewable
      Object.const_get(viewable_type.camelize)
    end

end