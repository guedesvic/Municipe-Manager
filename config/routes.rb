Rails.application.routes.draw do
  
  namespace :admins_backoffice do
    get 'welcome/index'
    get 'admins/index'
    get 'admins/municipes'
    get 'admins/:id/edit', to: 'admins#edit', as: 'edit_admin'
    get 'admins/:id/edit_registered_municipe', to: 'admins#edit_registered_municipe'
    get 'admins/search', to: 'search#municipes'
    get 'admins/filtered_municipios/:municipio_id', to: 'search#filtered_municipios', as: 'filtered_municipios'
  end

  namespace :site do
    get 'welcome/index'
  end

  resources :municipes, except: :destroy

  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/home', to: 'site/welcome#index'

  root to: "site/welcome#index"
end
