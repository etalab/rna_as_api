require 'rails_helper'

describe API::V1::FullTextController do
  context 'when doing unsuccessful search', type: :request do
    before { create(:association, siret: '123456', id: 1) }
    before { Association.reindex }

    it 'returns nothing' do
      get '/v1/siret/99999999'
      expect(response).to be_not_found_payload
    end
  end

  # Fulltext on titre
  context 'when searching on titre', type: :request do
    before { create(:association, siret: '123456', id: 1) }
    before { Association.reindex }

    it 'works' do
      get '/v1/siret/123456'
      expect(results_only_associations[:id]).to eq(1)
    end
  end
end
