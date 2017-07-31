require 'google/cloud/language'

class Sentiment::GoogleClient
  def self.sentiment_score(content)
    language   = Google::Cloud::Language.new(project: GoogleCloud::PROJECT, keyfile: GoogleCloud::KEYFILE)
    document   = language.document content
    annotation = document.annotate
    annotation.sentiment.score
  end
end
