include Redis::Wrapper
config = YAML::load_file(File.join(Rails.root, 'config', 'redis.yml'))[Rails.env]
$redis = Redis.new(:host => config["host"], :port => config["port"], :timeout => 5)