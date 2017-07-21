include Redis::Wrapper

config_raw = File.read(File.join(Rails.root, 'config', 'infra/redis.yml'))
config_erb = ERB.new(config_raw).result
config     = YAML.load(config_erb)[Rails.env].deep_symbolize_keys

$redis     = Redis.new(url: config[:url], timeout: config[:timeout])