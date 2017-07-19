module Akismet
  config = File.join(Rails.root, 'config', 'forli/akismet.yml')

  KEY = (YAML::load_file config)[Rails.env]
end