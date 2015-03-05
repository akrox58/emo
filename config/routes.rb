Rails.application.routes.draw do
  resources :comments

  resources :playlists

resources :songs do
 
  collection do
    get 'listofsong'
	get "/listening/:id" => "songs#listening"
  end
   


end

  resources :comments
  resources :moods

  resources :playlists

  resources :raters

  resources :populars

  resources :artists
  get "/search" => "songs#search", as: 'search'

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users

end
