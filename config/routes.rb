Rails.application.routes.draw do
  resources :comments

  resources :playlists

resources :songs do
 
  collection do
    get 'listofsong'
	get "/listening/:id" => "songs#listening"
get "/listenin/:id" => "songs#listenin"
  end
   


end

  resources :comments
  resources :moods

  resources :playlists

  resources :raters do
collection do
get "/signup" => "raters#signup"
get "/up/:id" => "raters#up"
end
end

  resources :populars

  resources :artists
  get "/search" => "songs#search", as: 'search'

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users

end
