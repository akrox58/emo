Rails.application.routes.draw do
  resources :comments

  resources :playlists

resources :songs do
  collection do
    get 'listofsong'
  end
end

  resources :comments
  resources :moods

  resources :playlists

  resources :raters

  resources :populars

  resources :artists


  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users

end
