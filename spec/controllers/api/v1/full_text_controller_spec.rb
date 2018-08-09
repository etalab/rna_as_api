require 'rails_helper'

describe API::V1::FullTextController do
  context 'when doing unsuccessful search', type: :request do
    before { create(:association, titre: 'foobar', id: 1) }
    before { Association.reindex }

    it 'returns nothing' do
      get '/v1/full_text/notfound'

      expect(response).to be_not_found_payload
    end
  end

  # Fulltext on titre
  context 'when searching on titre', type: :request do
    before { create(:association, titre: 'foobar', id: 1) }
    before { Association.reindex }

    it 'works' do
      get '/v1/full_text/foobar'

      expect(response).to find_one_association_with_id_1
    end
  end

  # Per page param
  context 'when specifying per_page', type: :request do
    let(:per_page_custom) { 15 }
    before { per_page_custom.times { create(:association, titre: 'foobar') } }
    before { Association.reindex }

    it 'return the right number of results' do
      get "/v1/full_text/foobar?per_page=#{per_page_custom}"
      expect(results_no_associations).to match(
        total_results: per_page_custom,
        total_pages: 1,
        per_page: per_page_custom,
        page: 1
      )
    end
  end

  # Limitation of per page param
  context 'when param per_page is over 100', type: :request do
    let(:per_page_asked) { 120 }
    let(:number_associations) { 10 }
    before { number_associations.times { create(:association, titre: 'foobar') } }
    before { Association.reindex }

    it 'returns results with 100 per_page' do
      get "/v1/full_text/foobar?per_page=#{per_page_asked}"

      expect(results_no_associations).to match(
        total_results: number_associations,
        total_pages: 1,
        per_page: 100,
        page: 1
      )
    end
  end
end
