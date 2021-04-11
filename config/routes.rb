Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'series#index'
  get '/search' => 'series#search'
  get '/personaje' => 'series#personajes'
  get '/series' => 'series#encontrar_series', as: :encontrar_series
  get '/episodes' => 'series#episodes'
  get '/episodeinfo' => 'series#episodeinfo'


end
