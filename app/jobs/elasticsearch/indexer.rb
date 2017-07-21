module Elasticsearch::Indexer
  class Create < ApplicationJob
    queue_as :es_indexer

    def perform(object)
      object.create_es_document
    end
  end

  class Update < ApplicationJob
    queue_as :es_indexer

    def perform(object)
      object.update_es_document
    end
  end

  class Delete < ApplicationJob
    queue_as :es_indexer

    def perform(index_name, type, document_id)
      ES_CLIENT.delete({
        index: index_name,
        type: type,
        id: document_id,
      })
    end
  end
end
