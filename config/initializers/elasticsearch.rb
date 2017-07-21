require 'elasticsearch'

config_raw = File.read(File.join(Rails.root, 'config', 'infra/elasticsearch.yml'))
config_erb = ERB.new(config_raw).result
config     = YAML.load(config_erb)[Rails.env].deep_symbolize_keys

Searchkick.client_options = {
  retry_on_failure: true
}