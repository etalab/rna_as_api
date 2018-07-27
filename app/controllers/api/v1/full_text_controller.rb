require 'sunspot'

class API::V1::FullTextController < ApplicationController
  def show
    page = fulltext_params[:page] || 1
    per_page = per_page_default_10_max_100
    fulltext_search(fulltext_params[:text], page, per_page)
  end

  private

  def per_page_default_10_max_100
    per_page = fulltext_params[:per_page] || 10
    per_page.to_i < 100 ? per_page : 100
  end

  def fulltext_search(query, page, per_page)
    search = search_with_solr_options(query, page, per_page)
    results = search.results

    if !results.blank?
      render_payload_success(search, results, page)
    else
      render_payload_not_found
    end
  end

  def search_with_solr_options(keyword, page, per_page)
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

  def render_payload_success(search, results, page)
    results_payload = {
      total_results: search.total,
      total_pages: results.total_pages,
      per_page: results.per_page,
      page: page,
      associations: results
    }
    render json: results_payload, status: 200
  end

  def render_payload_not_found
    results_payload = { message: 'no results found' }
    render json: results_payload, status: 404
  end
end
