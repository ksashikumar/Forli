class Search::Indexer < ApplicationJob
  queue_as :search_indexer

  def perform(options)
    searchable_id   = options[:searchable_id]
    searchable_type = options[:searchable_type]
    object = Object.const_get(searchable_type).find_by_id(searchable_id)
    object.reindex
  end
end
