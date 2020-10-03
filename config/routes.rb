Rails.application.routes.draw do
  # post '/wiki', to: 'textedit#wiki'
  post '/wiki' => 'textedit#wiki'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
