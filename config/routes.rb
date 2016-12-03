Rails.application.routes.draw do
  resources :users do
    collection do
      get :friends
    end
    member do
      get :feed
    end
  end

  resources :locations

  resources :indoor_locations

  resources :check_ins

  resources :events

  resources :friend_requests

  resources :invites

  root to: 'users#feed'
end
