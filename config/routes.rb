Rails.application.routes.draw do
  resources :users do
    collection do
      get :friends
    end
    member do
      get :feed
      patch :send_friend_request
    end
  end

  resources :locations

  resources :indoor_locations

  resources :check_ins

  resources :events

  resources :friend_requests do
    member do
      patch :accept
      patch :reject
    end
  end

  resources :invites

  resources :ratings do
    member do
      patch :upvote
      patch :downvote
    end
  end

  root to: 'users#feed'
end
