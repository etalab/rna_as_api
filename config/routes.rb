Rails.application.routes.draw do
  namespace :v1 do
    get 'full_text/:text' => '/api/v1/full_text#show'
  end
end
