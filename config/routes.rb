Rails.application.routes.draw do
  root 'start_playing#index'

  resources :users

  get '/play' => 'start_playing#play'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'


  get '/hit' => 'start_playing#player_hit'
  get '/stand' => 'start_playing#player_stand'
  get '/results/:id' => 'start_playing#result' 

  get '/stats' => 'start_playing#statistics'
end
