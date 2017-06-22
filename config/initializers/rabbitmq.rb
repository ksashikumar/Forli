# $rabbitmq_config = YAML::load_file(File.join(Rails.root, 'config/forli', 'rabbitmq.yml'))[Rails.env]
# rabbitmq_connection = Bunny.new($rabbitmq_config["connection_config"].symbolize_keys)
# rabbitmq_connection.start