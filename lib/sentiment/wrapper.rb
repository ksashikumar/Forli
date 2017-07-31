class Sentiment::Wrapper
  def self.analyze(content)
    # Sentiment::AlgorithmiaClient.sentiment_score(content)
    Sentiment::GoogleClient.sentiment_score(content)
  end
end
