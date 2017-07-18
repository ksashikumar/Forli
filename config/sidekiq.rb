config = YAML::load_file(File.join(Rails.root, 'config', 'sidekiq.yml'))[Rails.env]

redis_conn = proc {
  Redis.new(:host => config["host"], :port => config["port"])
}

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 5, &redis_conn)
end

Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 25, &redis_conn)
end