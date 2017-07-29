module Sentiment::Util
  def perform_sentiment_analyze
    sentiment_analyze_params = { obj_id: id, obj_type: self.class.to_s }
    Sentiment::Analyzer.perform_later(sentiment_analyze_params)
  end

  def sentiment_analyze_enabled?; end
end
