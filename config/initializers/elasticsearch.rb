require 'elasticsearch'

config_raw = File.read(File.join(Rails.root, 'config', 'infra/elasticsearch.yml'))
config_erb = ERB.new(config_raw).result
config     = YAML.load(config_erb)[Rails.env].deep_symbolize_keys

mapping_json  = JSON.parse(File.read(Rails.root.join('config/elasticsearch/mappings/discussion.json')))
template_json = File.read(Rails.root.join('config/elasticsearch/templates/discussion_search.json'))
analysis_json = JSON.parse(File.read(Rails.root.join('config/elasticsearch/mappings/analysis.json')))
mapping_json['settings']['analysis'] = analysis_json

ES_CLIENT = Elasticsearch::Client.new(config)

DISCUSSION_INDEX_NAME = 'forli_discussions'

DISCUSSION_SEARCH_MAPPING = mapping_json
DISCUSSION_MAPPING    = mapping_json
DISCUSSION_SEARCH_TEMPLATE = { name: 'discussion_search', type: 'discussion', query: template_json }

Elasticsearch::Transport::Client.class_eval do
  def add_template(args)
    uri = URI(config[:host] + '/_search/template/' + args[:id])
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = args[:body].gsub(/\n\s*/, '')
    Net::HTTP.new(uri.hostname, uri.port).request(req)
  end
end
