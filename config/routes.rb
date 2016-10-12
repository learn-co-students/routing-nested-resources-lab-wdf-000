Rails.application.routes.draw do

  resources :songs do
    resources :artist, only:[:show, :index]
  end

  resources :artists do
    resources :songs, only:[:show, :index]
  end
  
end
