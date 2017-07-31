class Sentiment::Analyzer < ApplicationJob
  queue_as :sentiment_analyzer

  def perform(options)
    obj_id    = options[:obj_id]
    obj_type  = options[:obj_type]
    object    = Object.const_get(obj_type).find_by_id(obj_id)

    sentiment_value = Sentiment::Wrapper.analyze(object.content)

    object.update_column(:sentiment, sentiment_value)
    object.reindex

    Reports::Data.update_avg_sentiment_score(sentiment_value, Object.const_get(obj_type).count) # count query is costly!
  rescue Exception => e
    Rails.logger.error("Exception in sentiment_analyzer: #{e.inspect}")
  end
end
