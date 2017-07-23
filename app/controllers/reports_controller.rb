class ReportsController < ApplicationController

  skip_before_action :load_objects

  def index
    render(json: { reports: reports_data }.to_json, status: 200)
  end

  def volume_trends
    search_term = if params[:term]
      params[:term]
    else
      "*"
    end
    search_hash = volume_trends_hash
    search_hash.merge!(fields: [:tags]) if search_term != "*"
    aggregated_response = Discussion.search(search_term, search_hash)
    response_array = construct_volume_array

    buckets_hash(aggregated_response).each do |val|
      response_array[(24 - Time.parse(val[:key_as_string]).hour)] = val[:doc_count]
    end

    render(json: {volume_trends: response_array}.to_json, status: 200)
  end

  def sentiment_trends
    # Need to find an optimized way to aggregate from ES. consider avg_bucket aggregation
  end

  protected

  def reports_data
    id = 1 # Just for the sake of ember-data
    data_arr = []
    ReportsConstants::TYPES.each do |type|
      data_hash = {}
      data_hash[:id]    = id
      data_hash[:type]  = type
      data_hash[:value] = Reports::Data.send(type)
      data_arr << data_hash
      id += 1
    end
    data_arr
  end

  def volume_trends_hash
    {
      where: {
        created_at: { gt: 1.day.ago }
      },
      aggs: {
        discussions_per_hour: {
          date_histogram: {
            field: :created_at,
            interval: :hour
          }
        }
      }
    }
  end

  def construct_volume_array
    response_hash = {}
    24.times.each do |val|
      response_hash[val] = 0
    end
    response_hash
  end

  def buckets_hash(aggregated_response)
    aggregations = aggregated_response.aggregations.deep_symbolize_keys!
    if aggregations[:discussions_per_hour]
      if aggregations[:discussions_per_hour][:discussions_per_hour]
        return aggregations[:discussions_per_hour][:discussions_per_hour][:buckets] || {}
      end
    end
  end

end