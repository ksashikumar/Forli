class Reports::Data
  include Redis::Keys

  def self.update_unanswered_count(incr)
    if incr
      $redis.perform('INCR', UNANSWERED_COUNT)
    elsif get_reports_value(UNANSWERED_COUNT).to_i.positive?
      $redis.perform('DECR', UNANSWERED_COUNT)
    end
  end

  def self.update_spammed_count(incr)
    if incr
      $redis.perform('INCR', SPAMMED_COUNT)
    elsif get_reports_value(SPAMMED_COUNT).to_i.positive?
      $redis.perform('DECR', SPAMMED_COUNT)
    end
  end

  def self.update_unpublished_count(incr)
    if incr
      $redis.perform('INCR', UNPUBLISHED_COUNT)
    elsif get_reports_value(UNPUBLISHED_COUNT).to_i.positive?
      $redis.perform('DECR', UNPUBLISHED_COUNT)
    end
  end

  def self.update_avg_sentiment_score(score, count)
    avg = get_reports_value(AVG_SENTIMENT_SCORE)
    new_avg = (((count - 1) * avg) + score) / count
    $redis.perform('SET', AVG_SENTIMENT_SCORE, new_avg)
  end

  def self.unanswered
    get_reports_value(UNANSWERED_COUNT) || 0 # Handle fallback to db if redis is down
  end

  def self.spammed
    get_reports_value(SPAMMED_COUNT) || 0 # Handle fallback to db if redis is down
  end

  def self.unpublished
    get_reports_value(UNPUBLISHED_COUNT) || 0 # Handle fallback to db if redis is down
  end

  def self.avg_sentiment_score
    get_reports_value(AVG_SENTIMENT_SCORE) || 0 # Handle fallback to db if redis is down
  end

  def self.get_reports_value(key)
    $redis.perform('GET', key)
  end
end
