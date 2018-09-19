require 'sunspot'

class API::V1::FullTextController < ApplicationController
  attr_accessor :page, :per_page
  def show
    @page = fulltext_params[:page] || 1
    @per_page = default_10_max_100(fulltext_params[:per_page])
    fulltext_search(fulltext_params[:text])
  end

  private

  def fulltext_search(query)
    @search = search_with_solr_options(query)
    @results = @search.results

    if !@results.blank?
      render json: payload_success, status: 200
    else
      render json: { message: 'no results found' }, status: 404
    end
  end

  def search_with_solr_options(keyword)
    search = Association.search do
      fulltext keyword do
        fields(titre: 1.0)
      end

      paginate page: page, per_page: per_page
    end
    search
  end

  def fulltext_params
    params.permit(
      :text,
      :page,
      :per_page
    )
  end

  def payload_success
    {
      total_results: @search.total,
      total_pages: @results.total_pages,
      per_page: per_page,
      page: page,
      association: @results
    }
  end
end
