module Akismet
  config_raw = File.read(File.join(Rails.root, 'config', 'forli/akismet.yml'))
  config_erb = ERB.new(config_raw).result
  config     = YAML.load(config_erb)[Rails.env].deep_symbolize_keys

  KEY = config[:key]
end