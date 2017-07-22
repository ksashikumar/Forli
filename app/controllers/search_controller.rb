class SearchController < ApplicationController

  before_action :load_object,  only: [:similar_discussions]

  def results
    @items = Discussion.search(params[:term], search_params)
    render_items
  end

  def suggested_discussions
    @items = Discussion.search(params[:term], suggested_search_params)
    suggested_hash = build_suggested_hash(@items)
    render(json: suggested_hash.to_json, status: 200)
  end

  def similar_discussions
    @items = @item.similar(similar_search_params)
    render_items
  end

  protected

  def default_where
    { deleted: false, spam: false, published: true }
  end

  def cname
    'discussions'
  end

  def load_object
    @item = Discussion.find_by_id(params[:id])
    render_404 unless @item
  end

  def build_suggested_hash(items)
    suggested_hash = { discussions: [], tags: [] }
    suggested_tags = []
    items.each do |item|
      item = item.to_hash.deep_symbolize_keys # Blind hack. Need to figure out a better way
      suggested_tags += item.slice(:tags)[:tags]
      suggested_hash[:discussions] << item.extract!(*DiscussionConstants::ES_INDEX_COLUMNS)
    end
    suggested_hash[:tags] = suggested_tags.uniq
    suggested_hash
  end

  def search_params
    {
      fields: [:title, :description],
      where: default_where,
      page: params[:page] || 1,
      per_page: 10,
      includes: DiscussionConstants::DISCUSSION_PRELOAD,
      match: :phrase
    }
  end

  def similar_search_params
    {
      fields: [:title, :description],
      where: default_where,
      page: 1,
      per_page: 10,
      includes: DiscussionConstants::DISCUSSION_PRELOAD
    }
  end

  def suggested_search_params
    {
      fields: [:title, :description],
      where: default_where,
      page: 1,
      per_page: 10,
      load: false # Returns from ES itself
    }
  end
end