Rails.application.routes.draw do
  resources :artists
  resources :songs, only: [:index, :show, :new, :create, :edit, :update]

  # resources :songs, only: [:index, :show]

  resources :artists, only: [:show, :index, :edit] do
    # nested resource for songs
    resources :songs, only: [:show, :index]
  end

  root 'songs#index'

end
