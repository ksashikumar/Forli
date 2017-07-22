class Sentiment::Analyzer < ApplicationJob
  queue_as :sentiment_analyzer

  def perform(options)
    begin
      obj_id   = options[:obj_id]
      obj_type = options[:obj_type]
      object    = Object.const_get(obj_type).find_by_id(obj_id)
      sentiment = Sentiment::AlgorithmiaClient.sentiment_analyze(algorithmia_options(object))
      object.update_column(:sentiment, sentiment[0]['sentiment'])
    rescue Exception => e
      Rails.logger.error("Exception in sentiment_analyzer: #{e.inspect}")
    end
  end

  def algorithmia_options(object)
    {
      api_key: Algorithmia::API_KEY,
      sentiment_algo: Algorithmia::SENTIMENT_ALGO,
      content: object.content
    }
  end
end
