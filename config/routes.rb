Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    root to: "home#index"

    #DEVISE:
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :clients, controllers: { registrations: 'client/registrations', sessions: 'client/sessions' }

    devise_for :sellers, controllers: { registrations: 'seller/registrations', sessions: 'seller/sessions' }, path_names: { registration: ENV['NEW_SELLER_PATH'] }

    #DASHBOARDS:
    get "c/:id/dashboard" => 'dashboard_clients#show', as: :client_dashboard
    resources :clients, path: "c", only: [:update, :destroy] do
      resource :basket, only: [:update], path: "b"
      resources :locations, only: [:create, :update, :destroy], path: "l"
    end

    get "s/:id/dashboard" => 'dashboard_sellers#show', as: :seller_dashboard
    resources :sellers, path: "s", only: [:update] do
      resources :products, only: [:create, :update, :destroy], path: "p"
      resources :locations, only: [:create, :update, :destroy], path: "l"
    end

    #CATALOGUE:
    get '/catalogue', to: 'products#index', as: 'catalogue'
    get '/seller/:id', to: 'sellers#show', as: 'seller_home'
    get '/seller/:id/p', to: 'products#index_seller', as: 'c_seller'
    get '/cat/:id', to: 'products#index_cat', as: 'c_category'
    get '/loc/:id', to: 'products#index_loc', as: 'c_location'
    get '/tag/:id', to: 'products#index_tag', as: 'c_tag'

    resources :products, only: :show

    resource :basket, only: :update

    # concern :manageable do
    #   resources :conversations, :orders...
    # end
  end
end

# get "c/:id/dashboard" => 'dashboard_clients#show', as: :client_dashboard
# resources :clients, path: "c", only: [:edit, :update, :destroy], path_names: { edit: "account" } do
#   resource :basket, only: [:edit, :update], path_names: { edit: "" }
#   resource :locations, only: [:edit, :update], path_names: { edit: "" }
# end

# get "s/:id/dashboard" => 'dashboard_sellers#show', as: :seller_dashboard
# resources :sellers, path: "s", only: [:edit, :update], path_names: { edit: "account" } do
#   resources :products, only: [:create, :edit, :update], path: "p", path_names: { edit: "edit" }
#   resources :locations, only: [:create, :edit, :update], path_names: { edit: "" }
# end
