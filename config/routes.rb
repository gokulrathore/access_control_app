Rails.application.routes.draw do
  post '/signup', to: 'accounts#signup'
  post '/login',  to: 'accounts#login'
  resources :organizations 
  get 'organization_analytics/:organization_id', to: 'organization_analytics#index'
  
  resources :community_events, only: [:index, :show ,:create]
  resources :parental_consents, only: [] do
    member do
      put :approve
    end
  end
end
