class AkismetClient
  require 'net/http'

  attr_accessor :attributes

  def initialize(attributes)
    self.attributes = attributes
  end

  def self.valid_key?(attributes)
    self.new(attributes).execute('verify-key')
  end

  def self.spam?(attributes)
    self.new(attributes).execute('comment-check') != "false"
  end

  def self.submit_spam(attributes)
    self.new(attributes).execute('submit-spam')
  end

  def self.submit_ham(attributes)
    self.new(attributes).execute('submit-ham')
  end

  def execute(command)
    host = "#{@attributes[:key]}." if attributes[:key] && command != 'verify-key'
    http = Net::HTTP.new("#{host}rest.akismet.com", 80)
    http.post("/1.1/#{command}", attributes_for_post, http_headers).body
  end

  private

  def http_headers
    {
      'User-Agent' => 'Akismetor Gem 1.1',
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
  end

  def attributes_for_post
    result = attributes.map { |k, v| "#{k}=#{v}" }.join('&')
    URI.escape(result)
  end
end