namespace :es_discussion do
  desc 'Delete discussion index'
  task delete_index: :environment do
    begin
      ES_CLIENT.indices.delete index: DISCUSSION_INDEX_NAME
    rescue Exception => e
      puts "Delete index failed : #{e.inspect}"
    end
  end

  desc 'Create discussion index'
  task create_index: :environment do
    ES_CLIENT.indices.create index: DISCUSSION_INDEX_NAME, body: DISCUSSION_SEARCH_MAPPING
  end

  desc 'Create discussion search template'
  task create_template: :environment do
    ES_CLIENT.add_template(
      id: DISCUSSION_SEARCH_TEMPLATE[:name],
      body: DISCUSSION_SEARCH_TEMPLATE[:query]
    )
  end

end
