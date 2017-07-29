module Search::Searchable
  extend ActiveSupport::Concern

  included do
    after_commit :create_in_es, on: :create
    after_commit :update_in_es, on: :update, if: :check_model_changes
  end

  private

  def create_in_es
    Search::Indexer.perform_later(searchable_id: id, searchable_type: self.class.to_s)
  end

  def update_in_es
    Search::Indexer.perform_later(searchable_id: id, searchable_type: self.class.to_s)
  end
end
