class Sentiment::AlgorithmiaClient
  def self.sentiment_score(content)
    api_key        = Algorithmia::API_KEY
    sentiment_algo = Algorithmia::SENTIMENT_ALGO
    client         = Algorithmia.client(api_key)
    algo           = client.algo(sentiment_algo)

    algo.pipe(document: content).result[0]['sentiment']
  end
end
