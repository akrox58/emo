Rails.application.routes.draw do
  resources :playlists

  resources :songs

  resources :moods

  resources :artists

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
resources :artist
resources :mood
resources :song
resources :playlist
resources :rater
resources :popular
end
