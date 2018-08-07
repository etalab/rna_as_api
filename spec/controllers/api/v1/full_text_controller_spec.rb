require 'rails_helper'

describe API::V1::FullTextController do
  context 'when doing a search that isnt found', type: :request do
    it 'doesnt return anything' do
      get '/v1/full_text/ghost_association_5678754579828655384'
      expect(response.body).to look_like_json
      expect(body_as_json).to match(
        message: 'no results found'
      )
      expect(response).to have_http_status(404)
    end
  end
end
