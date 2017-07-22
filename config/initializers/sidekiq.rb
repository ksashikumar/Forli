require 'sidekiq/web'

config_raw = File.read(File.join(Rails.root, 'config', 'sidekiq.yml'))
config_erb = ERB.new(config_raw).result
config     = YAML.load(config_erb)[Rails.env].deep_symbolize_keys

redis_conn = proc {
  Redis.new(url: config[:url])
}

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 30, &redis_conn)
end

Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 30, &redis_conn)
end

Sidekiq::Web.app_url = '/'