Rails.application.routes.draw do
  namespace :v1 do
    get 'full_text/:text' => '/api/v1/full_text#show'
    get 'id/:id' => '/api/v1/id_association#show'
    get 'siret/:siret' => '/api/v1/siret#show'
  end
end
