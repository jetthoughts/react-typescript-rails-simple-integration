Rails.application.routes.draw do
  resources :previews
  # get '/preview' => 'previews#index'
  # post '/preview/new' => 'previews#create'

  # post '/wiki', to: 'textedit#wiki'
  # post '/wiki' => 'textedit#wiki'
  post '/' => 'textedit#wiki'
  get '/wiki' => 'textedit#wiki'
  # get '/' => 'textedit#wiki'

  # get '/script' => 'script#index'
  get '/script/api/v1/:id' => 'script#input_fetch'
  post '/script/api/v1/:id' => 'script#output_fetch'
  # get '/script' => 'textedit#wiki'
  # get '/textedit/json_convert' => 'textedit#index'
  # post '/textedit/json_convert' => 'textedit#json'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  # IMPORTANT #
  # This `match` must be the *last* route in routes.rb
  match '*script', to: 'script#index', via: :all
end
