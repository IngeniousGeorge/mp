Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    root to: 'home#index'

    #miscelanious
    get '/about', to: 'home#about', as: 'about'
    get '/contact', to: 'home#contact', as: 'contact'

    #DEVISE:
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    devise_for :clients, controllers: { registrations: 'client/registrations', sessions: 'client/sessions' }

    devise_for :sellers, controllers: { registrations: 'seller/registrations', sessions: 'seller/sessions' }, path_names: { registration: ENV['NEW_SELLER_PATH'] }

    #DASHBOARDS:
    get "c/:id/dashboard" => 'dashboard_clients#show', as: :client_dashboard
    resources :clients, path: "c", only: [:update, :destroy] do
      resource :basket, only: :edit, path: "checkout"
      resources :basket_lines, only: :update, path: "b"
      resources :locations, only: [:create, :update, :destroy], path: "l"
    end

    get "s/:id/dashboard" => 'dashboard_sellers#show', as: :seller_dashboard
    resources :sellers, path: "s", only: [:update] do
      member { patch 'update_cover'}
      member { patch 'attach_image'}
      member { patch 'delete_image'}
      resources :products, only: [:create, :update, :destroy], path: "p" do
        member { patch 'update_cover'}
        member { patch 'attach_image' }
        member { patch 'delete_image' }
      end
      resources :locations, only: [:create, :update, :destroy], path: "l"
    end

    #CATALOGUE:
    # resources :sellers, only: :index
    resources :products, only: :show

    get '/catalogue(/:page)', to: 'products#index', as: 'catalogue'
    get '/s/:id(/:page)', to: 'products#index_seller', as: 'c_seller'
    get '/c/:id(/:page)', to: 'products#index_category', as: 'c_category'
    # get '/seller/:id', to: 'sellers#show', as: 'seller_show'
    # get '/loc/:id(/:page)', to: 'products#index_loc', as: 'c_location'
    # get '/tag/:id(/:page)', to: 'products#index_tag', as: 'c_tag'

    #CHECKOUT
    resource :basket, only: :edit, path: "checkout"
    resources :basket_lines, only: [:create, :update]

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
