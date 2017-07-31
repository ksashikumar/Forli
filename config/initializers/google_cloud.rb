module GoogleCloud
  config_raw = File.read(File.join(Rails.root, 'config', 'forli/google_cloud.yml'))
  config_erb = ERB.new(config_raw).result
  config     = YAML.safe_load(config_erb)[Rails.env].deep_symbolize_keys

  KEYFILE = config[:keyfile]
  PROJECT = config[:project]
  KEYFILE_CONTENT = config[:keyfile_content]

  FileUtils.mkdir('config/creds') unless File.directory?('config/creds')

  file = File.new(KEYFILE, 'w')
  file.write(JSON.parse(KEYFILE_CONTENT).to_json)
  file.close
end
