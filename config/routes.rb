Rails.application.routes.draw do
  # resources :artists

  # resources :artists
  # resources :artist , only: [:show,:index] do
  resources :artists do
    resources :songs, only: [:show,:index]
  end
  resources :songs
end
