Rails.application.routes.draw do
  resources :users do
    collection do
      get :friends
    end
    member do
      get :feed
    end
  end

  root to: 'users#feed'
end
