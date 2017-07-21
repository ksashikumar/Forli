module Elasticsearch::Searchable
  extend ActiveSupport::Concern

  included do
    after_commit :create_in_es, on: :create
    after_commit :update_in_es, on: :update, if: :check_model_changes
    after_commit :delete_in_es, on: :destroy
  end

  def create_es_document
    doc_params = es_document_params
    doc_params[:body] = {
      doc: doc_params[:body],
      doc_as_upsert: true
    }
    ES_CLIENT.update(doc_params)
  end

  def update_es_document
    doc_params = es_document_params
    doc_params[:body] = { doc: doc_params[:body] }
    ES_CLIENT.update(doc_params)
  end

  def es_document_params
    {
      index: es_index_name,
      type: es_document_type,
      id: es_document_id,
      body: es_document_payload
    }
  end

  def es_index_name
    DISCUSSION_INDEX_NAME
  end

  def es_document_type
    'discussion'
  end

  def es_document_id
    %(#{es_document_type}_#{id})
  end

  private

  def create_in_es
    Elasticsearch::Indexer::Create.perform_later(self)
  end

  def update_in_es
    Elasticsearch::Indexer::Update.perform_later(self)
  end

  def delete_in_es
    Elasticsearch::Indexer::Delete.perform_later(es_index_name, es_document_type, es_document_id)
  end
end
