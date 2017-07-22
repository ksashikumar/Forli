class Sentiment::AlgorithmiaClient

  def self.sentiment_analyze(options)
    api_key        = options[:api_key]
    sentiment_algo = options[:sentiment_algo]
    content        = options[:content]
    client         = Algorithmia.client(api_key)
    algo           = client.algo(sentiment_algo)

    return algo.pipe(document: content).result
  end

end