Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root to: "home#index"

  resources :posts do
    resources :comments
  end
end
