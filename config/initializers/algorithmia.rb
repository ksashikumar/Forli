module Algorithmia
  config_raw = File.read(File.join(Rails.root, 'config', 'forli/algorithmia.yml'))
  config_erb = ERB.new(config_raw).result
  config     = YAML.load(config_erb)[Rails.env].deep_symbolize_keys

  API_KEY        = config[:api_key]
  SENTIMENT_ALGO = config[:sentiment_algo]
end